#include <vector>
#include <algorithm> // Required for std::max

class Solution {
public:
    int longestNiceSubarray(std::vector<int>& nums) {
        int max_len = 0;
        int left = 0;
        std::vector<int> bit_counts(10, 0); // Stores counts for bits 0-9

        for (int right = 0; right < nums.size(); ++right) {
            int num = nums[right];

            // Process the current number nums[right]
            // For each bit set in nums[right], increment its count in bit_counts.
            // If incrementing a bit's count causes it to exceed 1, it means
            // nums[right] shares that bit with at least one other number already
            // in the window [left, right-1]. This violates the "nice" condition.
            // We must shrink the window from the left until this conflict is resolved.
            for (int k = 0; k < 10; ++k) {
                if ((num >> k) & 1) { // If the k-th bit is set in num
                    bit_counts[k]++;

                    // If this bit's count becomes greater than 1, shrink the window from the left
                    // until this specific bit's count is 1 again (or 0 if the left_num was the only one).
                    while (bit_counts[k] > 1) {
                        int left_num = nums[left];
                        // Decrement counts for all bits set in nums[left]
                        for (int b = 0; b < 10; ++b) {
                            if ((left_num >> b) & 1) {
                                bit_counts[b]--;
                            }
                        }
                        left++; // Move the left pointer to shrink the window
                    }
                }
            }

            // After processing nums[right] and ensuring the window [left, right] is nice,
            // update the maximum length found so far.
            max_len = std::max(max_len, right - left + 1);
        }

        return max_len;
    }
};