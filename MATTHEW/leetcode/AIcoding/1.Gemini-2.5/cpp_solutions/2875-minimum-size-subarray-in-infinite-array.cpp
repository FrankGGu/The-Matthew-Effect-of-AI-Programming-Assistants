#include <vector>
#include <numeric>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minSizeSubarray(std::vector<int>& nums, int target) {
        long long n = nums.size();
        long long s = 0;
        for (int x : nums) {
            s += x;
        }

        long long total_len = 0;
        long long current_target = target;

        if (current_target >= s) {
            total_len += (current_target / s) * n;
            current_target %= s;
        }

        if (current_target == 0) {
            return static_cast<int>(total_len);
        }

        long long min_len_remaining = std::numeric_limits<long long>::max();
        long long current_sum = 0;
        int left = 0;

        for (int right = 0; right < 2 * n; ++right) {
            current_sum += nums[right % n];

            while (current_sum >= current_target) {
                if (current_sum == current_target) {
                    min_len_remaining = std::min(min_len_remaining, (long long)right - left + 1);
                }
                current_sum -= nums[left % n];
                left++;
            }
        }

        if (min_len_remaining == std::numeric_limits<long long>::max()) {
            return -1;
        } else {
            return static_cast<int>(total_len + min_len_remaining);
        }
    }
};