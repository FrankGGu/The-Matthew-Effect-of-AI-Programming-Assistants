#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memcpy

int** g_result;
int* g_returnColumnSizes;
int g_returnSize;
int g_resultCapacity;

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

void backtrack(int* nums, int numsSize, bool* used, int* currentPermutation, int currentSize) {
    // Base case: If the current permutation is complete
    if (currentSize == numsSize) {
        // If capacity is reached, double it
        if (g_returnSize == g_resultCapacity) {
            g_resultCapacity *= 2;
            g_result = (int**)realloc(g_result, g_resultCapacity * sizeof(int*));
            g_returnColumnSizes = (int*)realloc(g_returnColumnSizes, g_resultCapacity * sizeof(int));
        }
        // Allocate memory for the new permutation and copy it
        g_result[g_returnSize] = (int*)malloc(numsSize * sizeof(int));
        memcpy(g_result[g_returnSize], currentPermutation, numsSize * sizeof(int));
        g_returnColumnSizes[g_returnSize] = numsSize;
        g_returnSize++;
        return;
    }

    // Iterate through available numbers
    for (int i = 0; i < numsSize; i++) {
        // Skip if the number is already used in the current permutation
        if (used[i]) {
            continue;
        }

        // Handle duplicates:
        // If the current number is the same as the previous number,
        // AND the previous number was NOT used (meaning it was just backtracked from),
        // then skip the current number to avoid generating duplicate permutations.
        if (i > 0 && nums[i] == nums[i-1] && !used[i-1]) {
            continue;
        }

        // Choose: Mark as used, add to current permutation
        used[i] = true;
        currentPermutation[currentSize] = nums[i];

        // Recurse: Explore next level
        backtrack(nums, numsSize, used, currentPermutation, currentSize + 1);

        // Unchoose (Backtrack): Mark as unused
        used[i] = false;
    }
}

int** permuteUnique(int* nums, int numsSize, int* returnSize, int** returnColumnSizesPtr) {
    // Initialize global variables for results
    g_resultCapacity = 45000; // Max 8! = 40320, so 45000 is a safe initial capacity
    g_result = (int**)malloc(g_resultCapacity * sizeof(int*));
    g_returnColumnSizes = (int*)malloc(g_resultCapacity * sizeof(int));
    g_returnSize = 0;

    // Sort the input array to group duplicates together, which is essential for the duplicate handling logic
    qsort(nums, numsSize, sizeof(int), compare);

    // Allocate memory for tracking used elements and the current permutation being built
    bool* used = (bool*)calloc(numsSize, sizeof(bool)); // calloc initializes to false
    int* currentPermutation = (int*)malloc(numsSize * sizeof(int));

    // Start the backtracking process
    backtrack(nums, numsSize, used, currentPermutation, 0);

    // Set the output parameters required by LeetCode
    *returnSize = g_returnSize;
    *returnColumnSizesPtr = g_returnColumnSizes;

    // Free temporary memory used by the backtracking process
    free(used);
    free(currentPermutation);

    // Return the array of permutations
    // The memory for g_result and g_returnColumnSizes (and their contents) is managed by the caller
    return g_result;
}