#include <vector>
#include <algorithm>

class Solution {
public:
    long long subArrayRanges(std::vector<int>& nums) {
        long long total_range_sum = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            int min_val = nums[i];
            int max_val = nums[i];
            for (int j = i; j < n; ++j) {
                min_val = std::min(min_val, nums[j]);
                max_val = std::max(max_val, nums[j]);
                total_range_sum += (long long)max_val - min_val;
            }
        }
        return total_range_sum;
    }
};