function findBooks(books) {
    return books.filter(book => book.copies === 0).map(book => book.title);
}