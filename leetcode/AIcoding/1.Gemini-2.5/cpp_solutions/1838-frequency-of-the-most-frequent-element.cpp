#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int maxFrequency(std::vector<int>& nums, long long k) {
        std::sort(nums.begin(), nums.end());

        int n = nums.size();
        int left = 0;
        long long current_sum = 0;
        int max_freq = 0;

        for (int right = 0; right < n; ++right) {
            current_sum += nums[right];

            // The condition for a valid window [left, right] is:
            // (nums[right] * (right - left + 1)) - current_sum <= k
            // This means the total operations needed to make all elements in the window
            // equal to nums[right] must not exceed k.
            while ((long long)nums[right] * (right - left + 1) - current_sum > k) {
                current_sum -= nums[left];
                left++;
            }

            // Update max_freq with the current window length
            max_freq = std::max(max_freq, right - left + 1);
        }

        return max_freq;
    }
};