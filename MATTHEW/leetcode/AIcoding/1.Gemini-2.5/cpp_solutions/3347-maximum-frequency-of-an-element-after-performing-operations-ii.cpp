#include <vector>
#include <algorithm>

class Solution {
public:
    int maxFrequency(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end());

        int n = nums.size();
        long long current_sum = 0;
        int left = 0;
        int max_freq = 0;

        for (int right = 0; right < n; ++right) {
            current_sum += nums[right];

            while ((long long)nums[right] * (right - left + 1) - current_sum > k) {
                current_sum -= nums[left];
                left++;
            }

            max_freq = std::max(max_freq, right - left + 1);
        }

        return max_freq;
    }
};