#include <vector>
#include <numeric>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int minOperations(std::vector<int>& nums, int k) {
        long long total_sum = 0;
        for (int num : nums) {
            total_sum += num;
        }

        int target_remainder = total_sum % k;

        if (target_remainder == 0) {
            return 0;
        }

        int n = nums.size();
        int min_len = n + 1; 

        std::unordered_map<int, int> remainder_map;
        remainder_map[0] = -1; 

        long long current_prefix_sum = 0;

        for (int i = 0; i < n; ++i) {
            current_prefix_sum += nums[i];
            int current_remainder = (current_prefix_sum % k + k) % k; // Ensure positive remainder

            int needed_prev_remainder = (current_remainder - target_remainder + k) % k;

            if (remainder_map.count(needed_prev_remainder)) {
                min_len = std::min(min_len, i - remainder_map[needed_prev_remainder]);
            }

            remainder_map[current_remainder] = i;
        }

        if (min_len == n + 1 || min_len == n) {
            return -1;
        }

        return min_len;
    }
};