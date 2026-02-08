#include <vector>
#include <numeric>
#include <unordered_map>

class Solution {
public:
    bool checkSubarraySum(std::vector<int>& nums, int k) {
        std::unordered_map<long long, int> remainder_map;
        remainder_map[0] = -1; 
        long long current_sum = 0;

        for (int i = 0; i < nums.size(); ++i) {
            current_sum += nums[i];

            if (k != 0) {
                current_sum %= k;
            }

            if (remainder_map.count(current_sum)) {
                int prev_idx = remainder_map[current_sum];
                if (i - prev_idx >= 2) {
                    return true;
                }
            } else {
                remainder_map[current_sum] = i;
            }
        }

        return false;
    }
};