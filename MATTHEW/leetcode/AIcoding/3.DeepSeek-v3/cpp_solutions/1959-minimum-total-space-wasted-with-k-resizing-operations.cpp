class Solution {
public:
    int minSpaceWastedKResizing(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<int>> dp(n, vector<int>(k + 1, INT_MAX / 2));
        vector<vector<int>> cost(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            int maxNum = nums[i];
            int sum = nums[i];
            for (int j = i + 1; j < n; ++j) {
                maxNum = max(maxNum, nums[j]);
                sum += nums[j];
                cost[i][j] = maxNum * (j - i + 1) - sum;
            }
        }

        for (int i = 0; i < n; ++i) {
            dp[i][0] = cost[0][i];
        }

        for (int l = 1; l <= k; ++l) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < i; ++j) {
                    dp[i][l] = min(dp[i][l], dp[j][l - 1] + cost[j + 1][i]);
                }
            }
        }

        return dp[n - 1][k];
    }
};