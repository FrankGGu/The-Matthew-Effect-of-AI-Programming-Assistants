#include <stdlib.h> // Required for calloc and free

int numSubarraysWithSum(int* nums, int numsSize, int goal) {
    // freq array to store the count of each prefix sum encountered so far.
    // The maximum possible prefix sum is numsSize (if all elements are 1).
    // So, we need an array of size numsSize + 1 to cover sums from 0 to numsSize.
    int* freq = (int*)calloc(numsSize + 1, sizeof(int));

    // Handle potential allocation failure, though LeetCode environments usually guarantee success.
    if (freq == NULL) {
        return 0; 
    }

    int count = 0;         // Total number of subarrays with sum 'goal'
    int current_sum = 0;   // Current prefix sum

    // Initialize freq[0] to 1. This represents the prefix sum of an empty array (before any elements),
    // which is 0. This is crucial for correctly counting subarrays that start from index 0
    // and have a sum equal to 'goal'.
    freq[0] = 1; 

    // Iterate through the input array
    for (int i = 0; i < numsSize; i++) {
        current_sum += nums[i]; // Update the current prefix sum

        // Check if a previous prefix sum (current_sum - goal) exists.
        // If it does, any subarray starting after that previous prefix sum and ending at the current index 'i'
        // will have a sum equal to 'goal'.
        // The condition `current_sum - goal >= 0` ensures we are looking for a valid non-negative sum.
        // The condition `current_sum - goal <= numsSize` ensures the index is within the bounds of `freq`.
        if (current_sum - goal >= 0 && current_sum - goal <= numsSize) {
            count += freq[current_sum - goal];
        }

        // Increment the frequency of the current prefix sum
        freq[current_sum]++;
    }

    // Free the dynamically allocated memory
    free(freq); 
    return count;
}