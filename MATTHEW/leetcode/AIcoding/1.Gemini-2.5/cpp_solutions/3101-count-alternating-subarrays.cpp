#include <vector>
#include <numeric>

class Solution {
public:
    long long countAlternatingSubarrays(std::vector<int>& nums) {
        long long total_alternating_subarrays = 0;
        int current_alternating_length = 0;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            if (i > 0 && nums[i] != nums[i - 1]) {
                current_alternating_length++;
            } else {
                current_alternating_length = 1;
            }
            total_alternating_subarrays += current_alternating_length;
        }

        return total_alternating_subarrays;
    }
};