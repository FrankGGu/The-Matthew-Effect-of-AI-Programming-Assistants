#include <stdlib.h> // For malloc

static inline int int_max(int a, int b) {
    return a > b ? a : b;
}

static inline int int_min(int a, int b) {
    return a < b ? a : b;
}

int* findKDistantIndices(int* nums, int numsSize, int key, int k, int* returnSize) {
    // Use an integer array as a boolean array to mark k-distant indices.
    // 0 means not k-distant, 1 means k-distant.
    // Variable Length Array (VLA) is used here, which is a C99 feature.
    int is_k_distant[numsSize];
    for (int i = 0; i < numsSize; ++i) {
        is_k_distant[i] = 0; // Initialize all indices as not k-distant
    }

    // First pass: Iterate through nums to find occurrences of 'key'.
    // For each 'key' found at index 'j', mark all indices 'i' within [j-k, j+k]
    // (and within array bounds) as k-distant.
    for (int j = 0; j < numsSize; ++j) {
        if (nums[j] == key) {
            // Calculate the range [start_i, end_i] for current 'j'
            int start_i = int_max(0, j - k);
            int end_i = int_min(numsSize - 1, j + k);

            // Mark all indices within this range as k-distant
            for (int i = start_i; i <= end_i; ++i) {
                is_k_distant[i] = 1;
            }
        }
    }

    // Second pass: Count the total number of unique k-distant indices
    int count = 0;
    for (int i = 0; i < numsSize; ++i) {
        if (is_k_distant[i] == 1) {
            count++;
        }
    }

    // Allocate memory for the result array
    int* result = (int*)malloc(count * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL; // Handle memory allocation failure
    }

    // Populate the result array with the k-distant indices in increasing order
    int current_result_idx = 0;
    for (int i = 0; i < numsSize; ++i) {
        if (is_k_distant[i] == 1) {
            result[current_result_idx++] = i;
        }
    }

    *returnSize = count; // Set the size of the returned array
    return result;
}