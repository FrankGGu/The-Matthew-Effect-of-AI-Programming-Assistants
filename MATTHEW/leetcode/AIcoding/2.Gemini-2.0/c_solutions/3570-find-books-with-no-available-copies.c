#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct book_loan {
    int book_id;
    int quantity;
};

int* find_books_with_no_available_copies(struct book_loan* loans, int loans_size, int* returnSize) {
    int book_count[10001] = {0};
    int i;

    for (i = 0; i < loans_size; i++) {
        book_count[loans[i].book_id] += loans[i].quantity;
    }

    int count = 0;
    for (i = 1; i <= 10000; i++) {
        if (book_count[i] > 0) {
            count++;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int index = 0;
    for (i = 1; i <= 10000; i++) {
        if (book_count[i] > 0) {
            result[index++] = i;
        }
    }

    *returnSize = count;
    return result;
}