#include <vector>
#include <algorithm>

class Solution {
public:
    long long minIncrementOperations(std::vector<int>& nums, int k) {
        long long dp1 = 0;
        long long dp2 = 0;
        long long dp3 = 0;

        for (int x : nums) {
            long long cost = std::max(0LL, (long long)k - x);
            long long current_dp = cost + std::min({dp1, dp2, dp3});
            dp1 = dp2;
            dp2 = dp3;
            dp3 = current_dp;
        }

        return std::min({dp1, dp2, dp3});
    }
};