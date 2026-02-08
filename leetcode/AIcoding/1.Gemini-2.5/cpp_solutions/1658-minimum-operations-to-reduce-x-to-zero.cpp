#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minOperations(std::vector<int>& nums, int x) {
        long long total_sum = 0;
        for (int num : nums) {
            total_sum += num;
        }

        long long target_sum = total_sum - x;

        if (target_sum < 0) {
            return -1;
        }

        if (target_sum == 0) {
            return nums.size();
        }

        int max_len = -1;
        long long current_sum = 0;
        int left = 0;

        for (int right = 0; right < nums.size(); ++right) {
            current_sum += nums[right];
            while (current_sum > target_sum && left <= right) {
                current_sum -= nums[left];
                left++;
            }
            if (current_sum == target_sum) {
                max_len = std::max(max_len, right - left + 1);
            }
        }

        if (max_len == -1) {
            return -1;
        } else {
            return nums.size() - max_len;
        }
    }
};