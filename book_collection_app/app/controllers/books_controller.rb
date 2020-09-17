class BooksController < ApplicationController
  def index
    @books = Book.order(:title)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    #Instantiate new object using form parameters
    @book = Book.new(book_params)

    #temp = @book.published_date.split(',')
   
    if @book.save
      #redirect to index if successful
      flash[:notice] = "Book created successfully"
      redirect_to(books_path)
    else
      render('new')
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    #Find new object using form parameters
    @book = Book.find(params[:id])
    #Update the object
    if @book.update_attributes(book_params)
      #Redirect to index
      flash[:notice] = "Book updated successfully"
      redirect_to(books_path)
    else
      render('edit')
    end
  end

  def delete
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Book '#{@book.title}' deleted successfully"
    redirect_to(books_path)
  end

  private

  def book_params
    params.require(:book).permit(:title,:author,:genre,:price,:published_date)
  end

end
