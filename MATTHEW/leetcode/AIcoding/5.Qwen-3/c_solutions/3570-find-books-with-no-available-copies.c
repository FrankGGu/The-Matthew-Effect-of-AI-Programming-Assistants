#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* title;
    int available;
} Book;

Book* findBooksWithNoAvailableCopies(Book** books, int booksSize, int* returnSize) {
    int count = 0;
    for (int i = 0; i < booksSize; i++) {
        if (books[i]->available == 0) {
            count++;
        }
    }

    *returnSize = count;
    Book* result = (Book*)malloc(count * sizeof(Book));
    int index = 0;

    for (int i = 0; i < booksSize; i++) {
        if (books[i]->available == 0) {
            result[index].title = strdup(books[i]->title);
            result[index].available = books[i]->available;
            index++;
        }
    }

    return result;
}