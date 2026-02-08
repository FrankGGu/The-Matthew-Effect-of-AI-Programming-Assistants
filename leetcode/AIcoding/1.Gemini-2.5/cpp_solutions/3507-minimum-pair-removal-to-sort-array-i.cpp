#include <vector>

class Solution {
public:
    int minPairSum(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        int max_sum = 0;
        for (int i = 0; i < nums.size() / 2; ++i) {
            max_sum = std::max(max_sum, nums[i] + nums[nums.size() - 1 - i]);
        }
        return max_sum;
    }
};