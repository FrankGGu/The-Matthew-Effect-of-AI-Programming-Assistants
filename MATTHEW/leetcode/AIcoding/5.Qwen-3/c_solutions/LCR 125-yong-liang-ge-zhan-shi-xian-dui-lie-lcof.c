#include <stdio.h>
#include <stdlib.h>

int* rearrangeBook(int* books, int booksSize, int k, int* returnSize) {
    *returnSize = booksSize;
    int* result = (int*)malloc(booksSize * sizeof(int));
    int* temp = (int*)malloc(booksSize * sizeof(int));
    for (int i = 0; i < booksSize; i++) {
        temp[i] = books[i];
    }
    for (int i = 0; i < booksSize; i++) {
        if (i % k == 0) {
            for (int j = 0; j < k && i + j < booksSize; j++) {
                result[i + j] = temp[i + k - 1 - j];
            }
            i += k - 1;
        } else {
            result[i] = temp[i];
        }
    }
    free(temp);
    return result;
}