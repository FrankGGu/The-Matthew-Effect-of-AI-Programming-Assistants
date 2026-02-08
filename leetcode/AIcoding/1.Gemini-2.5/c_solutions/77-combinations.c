#include <stdlib.h>
#include <string.h>

void backtrack(int start, int n, int k,
               int* current_combination, int current_size,
               int*** result, int* result_count, int** result_column_sizes,
               int* result_capacity) {

    if (current_size == k) {
        if (*result_count == *result_capacity) {
            *result_capacity *= 2;
            *result = (int**)realloc(*result, (*result_capacity) * sizeof(int*));
            *result_column_sizes = (int*)realloc(*result_column_sizes, (*result_capacity) * sizeof(int));
        }
        (*result)[*result_count] = (int*)malloc(k * sizeof(int));
        memcpy((*result)[*result_count], current_combination, k * sizeof(int));
        (*result_column_sizes)[*result_count] = k;
        (*result_count)++;
        return;
    }

    // Pruning: The loop should run as long as there are enough elements left to pick.
    // We need (k - current_size) more elements.
    // There are (n - i + 1) elements available from 'i' to 'n'.
    // So, we need (n - i + 1) >= (k - current_size)
    // This means i <= n - (k - current_size) + 1
    for (int i = start; i <= n - (k - current_size) + 1; ++i) {
        current_combination[current_size] = i;
        backtrack(i + 1, n, k,
                  current_combination, current_size + 1,
                  result, result_count, result_column_sizes,
                  result_capacity);
    }
}

int** combine(int n, int k, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;

    int initial_capacity = 16;
    int** result = (int**)malloc(initial_capacity * sizeof(int*));
    int* column_sizes = (int*)malloc(initial_capacity * sizeof(int));
    int current_capacity = initial_capacity;

    int* current_combination = (int*)malloc(k * sizeof(int));

    backtrack(1, n, k,
              current_combination, 0,
              &result, returnSize, &column_sizes,
              &current_capacity);

    free(current_combination);

    if (*returnSize == 0) {
        free(result);
        free(column_sizes);
        *returnColumnSizes = NULL;
        return NULL;
    }

    result = (int**)realloc(result, (*returnSize) * sizeof(int*));
    column_sizes = (int*)realloc(column_sizes, (*returnSize) * sizeof(int));
    *returnColumnSizes = column_sizes;

    return result;
}