#include <vector>
#include <numeric>
#include <cmath>

class Solution {
public:
    int maxAndSum(const std::vector<int>& nums) {
        int n = nums.size();
        int maxAnd = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                maxAnd = std::max(maxAnd, nums[i] & nums[j]);
            }
        }
        return maxAnd;
    }
};