#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int largestSumAfterKNegations(int* nums, int numsSize, int k) {
    // Step 1: Sort the array in ascending order
    qsort(nums, numsSize, sizeof(int), compare);

    // Step 2: Iterate through the array and negate negative numbers
    // to make them positive, consuming k operations.
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < 0 && k > 0) {
            nums[i] = -nums[i];
            k--;
        }
    }

    // Step 3: If k is still greater than 0 after negating all possible negative numbers
    // (meaning all numbers in the array are now non-negative or we ran out of negatives).
    if (k > 0) {
        // We need to perform the remaining k negations. To maximize the sum,
        // we should repeatedly negate the number with the smallest absolute value.
        // Since all numbers are now non-negative, this is simply the smallest number.

        // Find the index of the minimum element in the current array.
        // The array might not be sorted after negating some elements.
        int min_val = nums[0];
        int min_idx = 0;
        for (int i = 1; i < numsSize; i++) {
            if (nums[i] < min_val) {
                min_val = nums[i];
                min_idx = i;
            }
        }

        // If k is odd, we must perform one final negation on the smallest element.
        // If k is even, performing two negations on the same element cancels out,
        // so no further change to the sum is needed.
        if (k % 2 == 1) {
            nums[min_idx] = -nums[min_idx];
        }
    }

    // Step 4: Calculate the sum of all elements in the modified array
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    return sum;
}