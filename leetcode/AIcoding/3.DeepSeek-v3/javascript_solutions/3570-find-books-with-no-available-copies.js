var findBooksWithNoAvailableCopies = function(books, orders) {
    const bookMap = new Map();
    for (const [id, copies] of books) {
        bookMap.set(id, copies);
    }

    for (const [bookId, quantity] of orders) {
        if (bookMap.has(bookId)) {
            const remaining = bookMap.get(bookId) - quantity;
            bookMap.set(bookId, Math.max(remaining, 0));
        }
    }

    const result = [];
    for (const [id, copies] of books) {
        if (bookMap.get(id) === 0) {
            result.push(id);
        }
    }

    return result.sort((a, b) => a - b);
};