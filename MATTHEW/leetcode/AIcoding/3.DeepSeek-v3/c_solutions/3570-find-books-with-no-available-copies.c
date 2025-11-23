#include <stdio.h>
#include <stdlib.h>

char** findBooks(int books_count, char** books, int* books_size, int copies_count, char** copies, int* copies_size, int* result_count) {
    int* available = (int*)calloc(books_count, sizeof(int));

    for (int i = 0; i < copies_count; i++) {
        for (int j = 0; j < books_count; j++) {
            if (strcmp(copies[i], books[j]) == 0) {
                available[j] = 1;
                break;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < books_count; i++) {
        if (!available[i]) {
            count++;
        }
    }

    char** result = (char**)malloc(count * sizeof(char*));
    int index = 0;
    for (int i = 0; i < books_count; i++) {
        if (!available[i]) {
            result[index] = (char*)malloc((strlen(books[i]) + 1) * sizeof(char));
            strcpy(result[index], books[i]);
            index++;
        }
    }

    *result_count = count;
    free(available);
    return result;
}