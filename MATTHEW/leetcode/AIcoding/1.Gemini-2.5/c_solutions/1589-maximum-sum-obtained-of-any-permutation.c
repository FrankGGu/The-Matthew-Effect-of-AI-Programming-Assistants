#include <stdlib.h> // For qsort, calloc
#include <string.h> // For memset (not strictly necessary with calloc)

int compareInt(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int maxSumRangeQuery(int* nums, int numsSize, int** requests, int requestsSize, int* requestsColSize) {
    long long MOD = 1e9 + 7;

    // Step 1: Calculate how many times each index is requested.
    // Use a difference array (also known as a sweep line or prefix sum on counts).
    // freq_diff[i] will store the change in frequency at index i.
    // Size numsSize + 1 to handle requests up to numsSize - 1.
    int* freq_diff = (int*)calloc(numsSize + 1, sizeof(int));
    // Error handling for calloc, though LeetCode environments usually guarantee success for typical sizes.
    if (freq_diff == NULL) {
        return -1; // Indicate an error
    }

    for (int i = 0; i < requestsSize; i++) {
        int start = requests[i][0];
        int end = requests[i][1];
        freq_diff[start]++;
        // Decrement at end + 1 to stop the count for the current request
        freq_diff[end + 1]--;
    }

    // Convert the difference array into actual frequencies for each index.
    // frequencies[i] will store how many times index i is requested.
    int* frequencies = (int*)calloc(numsSize, sizeof(int));
    if (frequencies == NULL) {
        free(freq_diff);
        return -1; // Indicate an error
    }

    frequencies[0] = freq_diff[0];
    for (int i = 1; i < numsSize; i++) {
        frequencies[i] = frequencies[i - 1] + freq_diff[i];
    }

    // The freq_diff array is no longer needed.
    free(freq_diff);

    // Step 2: Sort both the original nums array and the calculated frequencies array.
    // To maximize the sum, we should multiply the largest numbers from 'nums'
    // with the indices that are requested most frequently (highest frequencies).
    // Sorting both in ascending order allows us to pair the smallest number with the
    // smallest frequency, the second smallest number with the second smallest frequency,
    // and so on, effectively pairing the largest number with the largest frequency
    // when iterating from the end, or equivalently, pairing by index after sorting.
    qsort(nums, numsSize, sizeof(int), compareInt);
    qsort(frequencies, numsSize, sizeof(int), compareInt);

    // Step 3: Calculate the maximum possible sum.
    long long totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        // Multiply the i-th smallest number by the i-th smallest frequency.
        // This implicitly pairs the largest with largest, second largest with second largest, etc.
        totalSum = (totalSum + (long long)nums[i] * frequencies[i]) % MOD;
    }

    // The frequencies array is no longer needed.
    free(frequencies);

    return (int)totalSum;
}