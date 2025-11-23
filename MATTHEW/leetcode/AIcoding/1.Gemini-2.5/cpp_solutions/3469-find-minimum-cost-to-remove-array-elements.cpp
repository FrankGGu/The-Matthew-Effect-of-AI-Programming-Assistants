#include <vector>
#include <algorithm>

class Solution {
public:
    long long findMinimumCost(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        long long total_cost = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            total_cost += (long long)nums[i] * (n - i);
        }
        return total_cost;
    }
};