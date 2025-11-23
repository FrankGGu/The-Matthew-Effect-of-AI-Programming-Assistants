int countAtMostK(int* nums, int numsSize, int k) {
    if (k < 0) {
        return 0;
    }

    // freq array to store the count of each number in the current window.
    // Max value of nums[i] is numsSize, so size numsSize + 1 is sufficient.
    int freq[numsSize + 1];
    for (int i = 0; i <= numsSize; i++) {
        freq[i] = 0;
    }

    int left = 0;
    int count = 0;
    int distinct = 0; // Number of distinct integers in the current window

    for (int right = 0; right < numsSize; right++) {
        // Add nums[right] to the window
        if (freq[nums[right]] == 0) {
            distinct++;
        }
        freq[nums[right]]++;

        // Shrink the window from the left if the number of distinct integers exceeds k
        while (distinct > k) {
            freq[nums[left]]--;
            if (freq[nums[left]] == 0) {
                distinct--;
            }
            left++;
        }

        // All subarrays ending at 'right' and starting from 'left' are valid
        // because they have at most 'k' distinct integers.
        // The number of such subarrays is (right - left + 1).
        count += (right - left + 1);
    }
    return count;
}

int subarraysWithKDistinct(int* nums, int numsSize, int k) {
    // The number of subarrays with exactly K distinct integers
    // is equal to (number of subarrays with at most K distinct integers)
    // minus (number of subarrays with at most K-1 distinct integers).
    return countAtMostK(nums, numsSize, k) - countAtMostK(nums, numsSize, k - 1);
}