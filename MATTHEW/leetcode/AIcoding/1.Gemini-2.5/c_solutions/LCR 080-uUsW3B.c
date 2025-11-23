#include <stdlib.h>
#include <string.h> // For memcpy if needed, but direct assignment is fine here

void backtrack(int n, int k, int start, int* current_combination, int current_size,
               int*** result_ptr, int* result_size_ptr, int* result_capacity_ptr,
               int** returnColumnSizes_ptr, int* column_sizes_size_ptr, int* column_sizes_capacity_ptr) {

    // Base case: If current_size equals k, a combination is found
    if (current_size == k) {
        // Ensure capacity for result and returnColumnSizes
        if (*result_size_ptr == *result_capacity_ptr) {
            *result_capacity_ptr *= 2;
            if (*result_capacity_ptr == 0) *result_capacity_ptr = 1; // Handle initial 0 capacity if needed, though usually starts > 0
            *result_ptr = (int**)realloc(*result_ptr, sizeof(int*) * (*result_capacity_ptr));
            // Error handling for realloc is omitted as per LeetCode common practice
        }
        if (*column_sizes_size_ptr == *column_sizes_capacity_ptr) {
            *column_sizes_capacity_ptr *= 2;
            if (*column_sizes_capacity_ptr == 0) *column_sizes_capacity_ptr = 1;
            *returnColumnSizes_ptr = (int*)realloc(*returnColumnSizes_ptr, sizeof(int) * (*column_sizes_capacity_ptr));
            // Error handling for realloc is omitted
        }

        // Store the current combination
        (*result_ptr)[*result_size_ptr] = (int*)malloc(sizeof(int) * k);
        for (int i = 0; i < k; i++) {
            (*result_ptr)[*result_size_ptr][i] = current_combination[i];
        }
        (*returnColumnSizes_ptr)[*column_sizes_size_ptr] = k;

        (*result_size_ptr)++;
        (*column_sizes_size_ptr)++;
        return;
    }

    // Pruning: If remaining elements (n - i + 1) + current_size < k, we cannot form a valid combination
    // The loop iterates from 'start' to 'n'.
    // The condition 'k - current_size > n - i + 1' checks if the number of elements still needed
    // is greater than the number of available elements from 'i' to 'n'.
    // We can optimize the loop range directly:
    // The maximum value for 'i' should be such that there are at least 'k - current_size - 1' elements remaining after 'i'.
    // So, i + (k - current_size - 1) <= n  =>  i <= n - (k - current_size - 1)
    // i.e., i <= n - k + current_size + 1
    for (int i = start; i <= n - (k - current_size) + 1; i++) {
        current_combination[current_size] = i; // Choose 'i'
        backtrack(n, k, i + 1, current_combination, current_size + 1,
                  result_ptr, result_size_ptr, result_capacity_ptr,
                  returnColumnSizes_ptr, column_sizes_size_ptr, column_sizes_capacity_ptr);
        // No explicit "unchoose" is needed as the next iteration or recursive call will overwrite
        // current_combination[current_size] or manage its own state.
    }
}

int** combine(int n, int k, int* returnSize, int** returnColumnSizes) {
    // Initial capacity for dynamic arrays
    int initial_capacity = 10; 
    if (k > n) initial_capacity = 0; // No combinations possible
    if (k == 0) initial_capacity = 1; // One empty combination

    if (initial_capacity == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int** result = (int**)malloc(sizeof(int*) * initial_capacity);
    int result_size = 0;
    int result_capacity = initial_capacity;

    *returnColumnSizes = (int*)malloc(sizeof(int) * initial_capacity);
    int column_sizes_size = 0;
    int column_sizes_capacity = initial_capacity;

    int* current_combination = (int*)malloc(sizeof(int) * k); // Temporary array to build combinations

    // Start the backtracking process
    backtrack(n, k, 1, current_combination, 0,
              &result, &result_size, &result_capacity,
              returnColumnSizes, &column_sizes_size, &column_sizes_capacity);

    // Free the temporary array used for building combinations
    free(current_combination);

    // Trim excess memory if the final size is less than capacity
    if (result_size < result_capacity) {
        result = (int**)realloc(result, sizeof(int*) * result_size);
    }
    if (column_sizes_size < column_sizes_capacity) {
        *returnColumnSizes = (int*)realloc(*returnColumnSizes, sizeof(int) * column_sizes_size);
    }

    *returnSize = result_size;
    return result;
}