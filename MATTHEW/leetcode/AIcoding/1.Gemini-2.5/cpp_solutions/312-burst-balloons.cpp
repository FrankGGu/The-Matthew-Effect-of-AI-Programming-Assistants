#include <vector>
#include <algorithm>

class Solution {
public:
    int maxCoins(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> padded_nums(n + 2);
        padded_nums[0] = 1;
        padded_nums[n + 1] = 1;
        for (int i = 0; i < n; ++i) {
            padded_nums[i + 1] = nums[i];
        }

        int m = padded_nums.size();
        std::vector<std::vector<int>> dp(m, std::vector<int>(m, 0));

        for (int length = 2; length < m; ++length) { // length of the subarray to consider (j - i)
            for (int i = 0; i < m - length; ++i) {
                int j = i + length;
                for (int k = i + 1; k < j; ++k) { // k is the last balloon to burst in (i, j)
                    dp[i][j] = std::max(dp[i][j], dp[i][k] + dp[k][j] + padded_nums[i] * padded_nums[k] * padded_nums[j]);
                }
            }
        }

        return dp[0][m - 1];
    }
};