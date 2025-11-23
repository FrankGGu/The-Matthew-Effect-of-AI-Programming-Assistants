function findBooksWithNoAvailableCopies(books) {
    const result = [];
    for (const [title, copies] of books) {
        if (copies === "0") {
            result.push(title);
        }
    }
    return result;
}