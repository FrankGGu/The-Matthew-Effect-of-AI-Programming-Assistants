#include <stdlib.h> // Required for malloc and qsort

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int* minSubsequence(int* nums, int numsSize, int* returnSize) {
    // Calculate the total sum of all elements in the array
    int total_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        total_sum += nums[i];
    }

    // Sort the input array in descending order
    qsort(nums, numsSize, sizeof(int), compare);

    int current_subsequence_sum = 0;
    *returnSize = 0; // Initialize the count of elements in the subsequence

    // Allocate a temporary buffer to store the elements of the subsequence.
    // The maximum possible size of the subsequence is numsSize.
    int* temp_subsequence = (int*)malloc(sizeof(int) * numsSize);

    // Iterate through the sorted array, adding elements to the subsequence
    // until its sum is strictly greater than the sum of the remaining elements.
    for (int i = 0; i < numsSize; i++) {
        current_subsequence_sum += nums[i];
        temp_subsequence[*returnSize] = nums[i];
        (*returnSize)++;

        // Check the condition: sum of subsequence > sum of remaining elements
        if (current_subsequence_sum > (total_sum - current_subsequence_sum)) {
            break; // Condition met, we found the minimum subsequence
        }
    }

    // Allocate the final result array with the exact size determined
    int* result = (int*)malloc(sizeof(int) * (*returnSize));

    // Copy elements from the temporary buffer to the final result array
    for (int i = 0; i < *returnSize; i++) {
        result[i] = temp_subsequence[i];
    }

    // Free the temporary buffer
    free(temp_subsequence);

    return result;
}