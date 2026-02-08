#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int minimumCost(std::vector<int>& nums) {
        std::sort(nums.begin() + 1, nums.end());
        return nums[0] + nums[1] + nums[2];
    }
};