class Solution {
public:
    int maxCoins(vector<int>& nums) {
        int n = nums.size();
        vector<int> balloons(n + 2, 1);
        for (int i = 0; i < n; ++i) {
            balloons[i + 1] = nums[i];
        }
        int dp[n + 2][n + 2] = {0};

        for (int length = 1; length <= n; ++length) {
            for (int left = 1; left <= n - length + 1; ++left) {
                int right = left + length - 1;
                for (int i = left; i <= right; ++i) {
                    dp[left][right] = max(dp[left][right], 
                        dp[left][i - 1] + dp[i + 1][right] + balloons[left - 1] * balloons[i] * balloons[right + 1]);
                }
            }
        }

        return dp[1][n];
    }
};