#include <vector>
#include <numeric>

class Solution {
public:
    long long countSubarrays(std::vector<int>& nums, long long k) {
        long long count = 0;
        long long current_sum = 0;
        int left = 0;
        int n = nums.size();

        for (int right = 0; right < n; ++right) {
            current_sum += nums[right];

            // While the current window's score (sum * length) is greater than or equal to k,
            // shrink the window from the left.
            while (current_sum * (static_cast<long long>(right - left + 1)) >= k) {
                current_sum -= nums[left];
                left++;
            }

            // At this point, the window nums[left...right] has a score strictly less than k.
            // Any subarray ending at 'right' and starting from 'left' up to 'right'
            // will also have a score strictly less than k because:
            // 1. Its sum will be less than or equal to current_sum.
            // 2. Its length will be less than or equal to (right - left + 1).
            // Therefore, its score will be less than or equal to current_sum * (right - left + 1),
            // which is already less than k.
            // The number of such valid subarrays ending at 'right' is (right - left + 1).
            count += (right - left + 1);
        }

        return count;
    }
};