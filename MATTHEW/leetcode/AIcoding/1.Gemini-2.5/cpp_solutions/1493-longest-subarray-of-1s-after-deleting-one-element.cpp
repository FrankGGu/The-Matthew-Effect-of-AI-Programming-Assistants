#include <vector>
#include <algorithm>

class Solution {
public:
    int longestSubarray(std::vector<int>& nums) {
        int left = 0;
        int zero_count = 0;
        int max_len = 0;

        for (int right = 0; right < nums.size(); ++right) {
            if (nums[right] == 0) {
                zero_count++;
            }

            while (zero_count > 1) {
                if (nums[left] == 0) {
                    zero_count--;
                }
                left++;
            }

            // The current window [left, right] contains at most one zero.
            // The length of the subarray of 1's after deleting one element
            // (either the zero if it exists, or one of the ones if no zero exists)
            // is (right - left + 1) - 1 = right - left.
            max_len = std::max(max_len, right - left);
        }

        return max_len;
    }
};