#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minSubArrayLen(int target, std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        int min_length = INT_MAX;
        int current_sum = 0;
        int left = 0;

        for (int right = 0; right < n; ++right) {
            current_sum += nums[right];

            while (current_sum >= target) {
                min_length = std::min(min_length, right - left + 1);
                current_sum -= nums[left];
                left++;
            }
        }

        return (min_length == INT_MAX) ? 0 : min_length;
    }
};