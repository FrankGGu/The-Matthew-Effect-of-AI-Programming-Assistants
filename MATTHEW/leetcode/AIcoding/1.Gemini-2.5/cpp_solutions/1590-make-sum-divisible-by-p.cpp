#include <vector>
#include <numeric>
#include <map>
#include <algorithm>

class Solution {
public:
    int minSubarray(std::vector<int>& nums, int p) {
        long long total_sum = 0;
        for (int num : nums) {
            total_sum += num;
        }

        int remainder_total = total_sum % p;

        if (remainder_total == 0) {
            return 0;
        }

        std::map<int, int> remainder_to_index;
        remainder_to_index[0] = -1; 

        int current_sum_mod_p = 0;
        int min_len = nums.size(); 

        for (int i = 0; i < nums.size(); ++i) {
            current_sum_mod_p = (current_sum_mod_p + nums[i]) % p;

            int needed_remainder = (current_sum_mod_p - remainder_total + p) % p;

            if (remainder_to_index.count(needed_remainder)) {
                min_len = std::min(min_len, i - remainder_to_index[needed_remainder]);
            }

            remainder_to_index[current_sum_mod_p] = i;
        }

        if (min_len == nums.size()) {
            return -1;
        } else {
            return min_len;
        }
    }
};