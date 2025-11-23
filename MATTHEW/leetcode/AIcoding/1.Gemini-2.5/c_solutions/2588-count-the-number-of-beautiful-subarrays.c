#include <stdlib.h> // Required for calloc and free

long long numberOfSubarrays(int* nums, int numsSize, int k) {
    long long count = 0;
    int currentOddCount = 0;

    // freq array stores the frequency of prefix odd counts.
    // The maximum possible odd count is numsSize.
    // So, an array of size numsSize + 1 is needed to store frequencies
    // from 0 to numsSize.
    int* freq = (int*)calloc(numsSize + 1, sizeof(int));
    if (freq == NULL) {
        // Handle allocation failure, though unlikely on LeetCode.
        return 0;
    }

    // An empty prefix (before index 0) has 0 odd numbers.
    // Initialize its frequency to 1.
    freq[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        // If the current number is odd, increment the current odd count.
        if (nums[i] % 2 != 0) {
            currentOddCount++;
        }

        // If currentOddCount is at least k, it means we might have subarrays
        // ending at the current index with exactly k odd numbers.
        // We are looking for a previous prefix odd count such that:
        // currentOddCount - previousOddCount = k
        // previousOddCount = currentOddCount - k
        if (currentOddCount >= k) {
            count += freq[currentOddCount - k];
        }

        // Increment the frequency of the current odd count.
        freq[currentOddCount]++;
    }

    // Free the dynamically allocated memory.
    free(freq);

    return count;
}