#include <stdlib.h> // For malloc, calloc, free

int countSubarrays(int* nums, int numsSize, int k) {
    int k_idx = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == k) {
            k_idx = i;
            break;
        }
    }

    // Transform nums into an array where:
    // 1 if element > k
    // -1 if element < k
    // 0 if element == k
    int* transformed_nums = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > k) {
            transformed_nums[i] = 1;
        } else if (nums[i] < k) {
            transformed_nums[i] = -1;
        } else {
            transformed_nums[i] = 0; 
        }
    }

    // Frequencies of sums for the left part of subarrays (ending at k_idx - 1)
    // The sum can range from -(numsSize-1) to (numsSize-1).
    // We use an offset to map these sums to non-negative array indices.
    // Max absolute sum is numsSize - 1.
    int max_abs_sum = numsSize - 1; 
    int freq_array_size = 2 * max_abs_sum + 1;
    int offset = max_abs_sum; // Offset to map 0 to max_abs_sum index

    // Use calloc to initialize all elements to 0
    int* freq = (int*)calloc(freq_array_size, sizeof(int));

    int current_sum_left = 0;
    // The empty prefix before k_idx has a sum of 0.
    freq[current_sum_left + offset]++; 

    // Calculate sums for all prefixes ending before k_idx (from right to left)
    for (int i = k_idx - 1; i >= 0; i--) {
        current_sum_left += transformed_nums[i];
        freq[current_sum_left + offset]++;
    }

    int ans = 0;
    int current_sum_right = 0;

    // Iterate for the right part of subarrays (starting from k_idx)
    for (int j = k_idx; j < numsSize; j++) {
        // For elements to the right of k_idx, add their transformed value to current_sum_right
        // The element at k_idx (transformed_nums[k_idx]) is 0, so it doesn't affect the sum.
        // We only start adding from k_idx+1.
        if (j > k_idx) { 
            current_sum_right += transformed_nums[j];
        }

        // We are looking for subarrays [i, j] containing k_idx such that
        // (sum_left + sum_right) is 0 or 1.
        // sum_left is the sum of elements from i to k_idx-1.
        // sum_right is the sum of elements from k_idx+1 to j.
        // The total balance is current_sum_left + current_sum_right.
        // So we need current_sum_left == -current_sum_right or current_sum_left == 1 - current_sum_right.

        // Target 1: sum_left == -current_sum_right
        int target1 = -current_sum_right;
        if (target1 + offset >= 0 && target1 + offset < freq_array_size) {
            ans += freq[target1 + offset];
        }

        // Target 2: sum_left == 1 - current_sum_right
        int target2 = 1 - current_sum_right;
        if (target2 + offset >= 0 && target2 + offset < freq_array_size) {
            ans += freq[target2 + offset];
        }
    }

    free(transformed_nums);
    free(freq);

    return ans;
}