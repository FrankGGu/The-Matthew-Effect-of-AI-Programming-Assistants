#include <string.h> // Required for memset

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long maximumSubarraySum(int* nums, int numsSize, int k) {
    long long max_sum = 0;
    long long current_sum = 0;
    int distinct_count = 0;
    // freq array to store counts of numbers in the current window.
    // Max value of nums[i] is 10^5, so array size 100001 is sufficient.
    int freq[100001]; 
    memset(freq, 0, sizeof(freq)); // Initialize all frequencies to 0

    int left = 0;
    for (int right = 0; right < numsSize; ++right) {
        // Add the current element (nums[right]) to the window
        current_sum += nums[right];
        freq[nums[right]]++;
        if (freq[nums[right]] == 1) {
            // If this is the first occurrence of nums[right] in the window, increment distinct count
            distinct_count++;
        }

        // Shrink the window from the left if its size exceeds k
        while (right - left + 1 > k) {
            current_sum -= nums[left];
            freq[nums[left]]--;
            if (freq[nums[left]] == 0) {
                // If the count of nums[left] becomes 0, it's no longer in the window, decrement distinct count
                distinct_count--;
            }
            left++; // Move the left pointer
        }

        // If the window is exactly size k and all elements are distinct
        if (right - left + 1 == k) {
            if (distinct_count == k) {
                max_sum = max(max_sum, current_sum);
            }
        }
    }

    return max_sum;
}