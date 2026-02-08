var findBooksWithNoAvailableCopies = function(books) {
    return books
        .filter(book => book.available_copies === 0)
        .map(book => book.title);
};