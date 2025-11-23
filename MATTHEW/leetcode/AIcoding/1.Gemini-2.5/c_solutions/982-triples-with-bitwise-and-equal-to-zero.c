#include <stdlib.h> // For calloc, free

int triplesWithBitwiseAndEqualToZero(int* nums, int numsSize) {
    const int MAX_VAL = 1 << 16; // Represents 2^16, max value for numbers is 2^16 - 1

    // freq[val] stores the count of 'val' in the input array 'nums'.
    int* freq = (int*)calloc(MAX_VAL, sizeof(int));
    if (freq == NULL) {
        return -1; // Memory allocation failed
    }
    for (int i = 0; i < numsSize; ++i) {
        freq[nums[i]]++;
    }

    // dp2[mask] will store the count of numbers 'y' from 'nums'
    // such that 'y' is a submask of 'mask'.
    int* dp2 = (int*)calloc(MAX_VAL, sizeof(int));
    if (dp2 == NULL) {
        free(freq);
        return -1; // Memory allocation failed
    }
    // Initialize dp2 with individual frequencies
    for (int mask = 0; mask < MAX_VAL; ++mask) {
        dp2[mask] = freq[mask];
    }

    // Compute dp2 using Sum Over Subsets (SOS) DP
    // This process iterates through each bit position (0 to 15)
    // For each mask, if the current bit 'i' is set in 'mask',
    // it adds the count from the submask where bit 'i' is not set.
    // This effectively accumulates counts of all submasks into 'dp2[mask]'.
    for (int i = 0; i < 16; ++i) { // Iterate through each bit position (0 to 15)
        for (int mask = 0; mask < MAX_VAL; ++mask) {
            if ((mask >> i) & 1) { // If the i-th bit is set in 'mask'
                // Add counts from the submask where the i-th bit is NOT set
                dp2[mask] += dp2[mask ^ (1 << i)];
            }
        }
    }

    long long totalTriples = 0;
    int all_bits_mask = MAX_VAL - 1; // A mask with all 16 bits set (e.g., 0xFFFF)

    // Iterate through all possible pairs (nums[i], nums[j])
    for (int i = 0; i < numsSize; ++i) {
        for (int j = 0; j < numsSize; ++j) {
            int and_ij = nums[i] & nums[j];

            // We need to find nums[k] such that (and_ij & nums[k]) == 0.
            // This condition means that nums[k] must not have any bits set
            // where 'and_ij' has bits set.
            // In other words, nums[k] must be a submask of the bitwise NOT of 'and_ij'
            // (considering only the relevant 16 bits).
            int complement_and_ij = all_bits_mask ^ and_ij;

            // dp2[complement_and_ij] gives the count of numbers 'y' from 'nums'
            // such that 'y' is a submask of 'complement_and_ij'.
            // These are precisely the numbers that satisfy (and_ij & y) == 0.
            totalTriples += dp2[complement_and_ij];
        }
    }

    // Free allocated memory
    free(freq);
    free(dp2);

    return (int)totalTriples;
}