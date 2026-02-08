#include <stdlib.h>
#include <string.h>

void backtrack(int k, int n, int start_num, int* current_combination, int current_combination_size,
               int*** result, int* result_size, int* result_capacity, int** returnColumnSizes) {

    if (n < 0) {
        return;
    }

    if (k == 0) {
        if (n == 0) {
            if (*result_size == *result_capacity) {
                *result_capacity = (*result_capacity == 0) ? 1 : (*result_capacity * 2);
                *result = (int**)realloc(*result, sizeof(int*) * (*result_capacity));
                *returnColumnSizes = (int*)realloc(*returnColumnSizes, sizeof(int) * (*result_capacity));
            }

            (*result)[*result_size] = (int*)malloc(sizeof(int) * current_combination_size);
            memcpy((*result)[*result_size], current_combination, sizeof(int) * current_combination_size);
            (*returnColumnSizes)[*result_size] = current_combination_size;
            (*result_size)++;
        }
        return;
    }

    if (start_num > 9) {
        return;
    }

    // Pruning: Check if it's possible to form the sum 'n' with 'k' numbers
    // Minimum possible sum with k numbers starting from `start_num`:
    // start_num + (start_num + 1) + ... + (start_num + k - 1)
    int min_sum_possible = k * start_num + k * (k - 1) / 2;
    if (min_sum_possible > n) {
        return;
    }

    // Maximum possible sum with k numbers (using largest available from 9 down):
    // 9 + (9 - 1) + ... + (9 - k + 1)
    int max_sum_possible = k * 9 - k * (k - 1) / 2;
    if (max_sum_possible < n) {
        return;
    }

    for (int i = start_num; i <= 9; ++i) {
        if (i > n) {
            break;
        }

        current_combination[current_combination_size] = i;
        backtrack(k - 1, n - i, i + 1, current_combination, current_combination_size + 1,
                  result, result_size, result_capacity, returnColumnSizes);
    }
}

int** combinationSum3(int k, int n, int* returnSize, int** returnColumnSizes) {
    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;
    int result_capacity = 0;

    int current_combination[k];

    backtrack(k, n, 1, current_combination, 0,
              &result, returnSize, &result_capacity, returnColumnSizes);

    return result;
}