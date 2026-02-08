#include <stdbool.h>
#include <stdlib.h> // For qsort and malloc

int compare(const void *a, const void *b) {
    long long valA = *(long long*)a;
    long long valB = *(long long*)b;
    if (valA < valB) return -1;
    if (valA > valB) return 1;
    return 0;
}

bool findSubarrays(int* nums, int numsSize) {
    // According to LeetCode problem constraints, numsSize >= 2.
    // If numsSize < 2, there are no subarrays of length 2.
    if (numsSize < 2) {
        return false;
    }

    // There will be (numsSize - 1) subarrays of length 2.
    // The sum of two integers can exceed the range of `int` if `nums[i]` are large.
    // Using `long long` for sums to prevent potential overflow.
    long long* sums = (long long*)malloc((numsSize - 1) * sizeof(long long));
    if (sums == NULL) {
        // Handle memory allocation failure, though LeetCode environments usually guarantee success for reasonable sizes.
        return false;
    }

    // Calculate sums of all adjacent pairs
    for (int i = 0; i < numsSize - 1; i++) {
        sums[i] = (long long)nums[i] + nums[i+1];
    }

    // Sort the array of sums
    qsort(sums, numsSize - 1, sizeof(long long), compare);

    // Check for duplicate sums in the sorted array
    for (int i = 0; i < numsSize - 2; i++) {
        if (sums[i] == sums[i+1]) {
            free(sums); // Free allocated memory before returning
            return true;
        }
    }

    free(sums); // Free allocated memory
    return false;
}