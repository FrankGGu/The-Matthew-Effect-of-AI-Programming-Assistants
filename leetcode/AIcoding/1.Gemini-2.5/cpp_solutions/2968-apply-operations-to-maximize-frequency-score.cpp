#include <vector>
#include <algorithm>

class Solution {
public:
    int maxFrequency(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end());

        long long current_sum = 0;
        int max_freq = 0;
        int left = 0;

        for (int right = 0; right < nums.size(); ++right) {
            current_sum += nums[right];

            while ((long long)(right - left + 1) * nums[right] - current_sum > k) {
                current_sum -= nums[left];
                left++;
            }

            max_freq = std::max(max_freq, right - left + 1);
        }

        return max_freq;
    }
};