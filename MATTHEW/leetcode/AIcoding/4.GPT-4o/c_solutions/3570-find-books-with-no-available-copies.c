typedef struct {
    int id;
    int availableCopies;
} Book;

int* findBooksWithNoAvailableCopies(Book* books, int booksSize, int* returnSize) {
    int* result = (int*)malloc(booksSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < booksSize; i++) {
        if (books[i].availableCopies == 0) {
            result[(*returnSize)++] = books[i].id;
        }
    }

    result = (int*)realloc(result, (*returnSize) * sizeof(int));
    return result;
}