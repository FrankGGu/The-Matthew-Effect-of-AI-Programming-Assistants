#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int** global_result;
int* global_columnSizes;
int global_result_idx;

void backtrack(int* nums, int numsSize, int start, int* currentSubset, int currentSize) {
    // Add the current subset to the result list
    global_result[global_result_idx] = (int*)malloc(currentSize * sizeof(int));
    memcpy(global_result[global_result_idx], currentSubset, currentSize * sizeof(int));
    global_columnSizes[global_result_idx] = currentSize;
    global_result_idx++;

    // Iterate through the remaining elements to build subsets
    for (int i = start; i < numsSize; i++) {
        // Skip duplicates: if the current element is the same as the previous one
        // and it's not the first element considered at this level of recursion (i > start),
        // then skip it to avoid duplicate subsets.
        if (i > start && nums[i] == nums[i-1]) {
            continue;
        }

        // Include the current element in the subset
        currentSubset[currentSize] = nums[i];
        // Recurse with the next element
        backtrack(nums, numsSize, i + 1, currentSubset, currentSize + 1);
        // Backtrack: no explicit removal needed as currentSize manages the logical size
        // and elements are overwritten in subsequent calls.
    }
}

int** subsetsWithDup(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    // Sort the input array to easily handle duplicates.
    qsort(nums, numsSize, sizeof(int), compare);

    // The maximum number of subsets for an array of size N is 2^N.
    int max_subsets = 1 << numsSize;

    // Allocate memory for the global result arrays.
    global_result = (int**)malloc(max_subsets * sizeof(int*));
    global_columnSizes = (int*)malloc(max_subsets * sizeof(int));
    global_result_idx = 0; // Initialize result index

    // Allocate a temporary array to build individual subsets.
    // Its size is max_numsSize because a subset can contain up to all elements.
    int* currentSubset = (int*)malloc(numsSize * sizeof(int));

    // Start the backtracking process
    backtrack(nums, numsSize, 0, currentSubset, 0);

    // Free the temporary subset array
    free(currentSubset);

    // Set the output parameters required by LeetCode
    *returnSize = global_result_idx;
    *returnColumnSizes = global_columnSizes;

    // Return the array of subsets
    return global_result;
}