#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minOperations(int* nums, int numsSize, int k, int threshold) {
    // Sort the array in ascending order.
    // This allows us to process elements from smallest to largest,
    // simulating the removal of the smallest element.
    qsort(nums, numsSize, sizeof(int), compare);

    int operations = 0;
    int satisfied_count = 0;

    // Iterate through the sorted array
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < threshold) {
            // If the current smallest element is less than the threshold,
            // it must be removed to contribute to the k elements that meet the threshold.
            // This counts as one operation.
            operations++;
        } else {
            // If the current smallest element meets or exceeds the threshold,
            // it can be one of the k desired elements.
            satisfied_count++;
        }

        // Once we have found k elements that meet or exceed the threshold,
        // we have performed the minimum number of operations necessary.
        // The problem guarantees that it's always possible to find k such elements.
        if (satisfied_count == k) {
            break;
        }
    }

    return operations;
}