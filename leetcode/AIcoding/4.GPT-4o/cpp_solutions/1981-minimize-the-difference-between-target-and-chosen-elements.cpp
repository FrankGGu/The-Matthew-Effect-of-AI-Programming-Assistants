#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minimizeTheDifference(std::vector<std::vector<int>>& mat, int target) {
        int m = mat.size(), n = mat[0].size();
        std::vector<bool> dp(5001, false);
        dp[0] = true;

        for (const auto& row : mat) {
            std::vector<bool> new_dp(5001, false);
            for (int num : row) {
                for (int j = 5000; j >= num; --j) {
                    new_dp[j] = new_dp[j] || dp[j - num];
                }
            }
            dp = new_dp;
        }

        int closest = INT_MAX;
        for (int sum = 0; sum <= 5000; ++sum) {
            if (dp[sum]) {
                closest = std::min(closest, std::abs(target - sum));
            }
        }

        return closest;
    }
};