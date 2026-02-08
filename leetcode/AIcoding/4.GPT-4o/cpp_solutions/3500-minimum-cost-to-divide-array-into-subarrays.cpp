class Solution {
public:
    int minCost(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, INT_MAX));
        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= k; ++j) {
                int unique = 0;
                unordered_map<int, int> count;
                for (int m = i; m > 0; --m) {
                    if (++count[nums[m - 1]] == 1) unique++;
                    dp[i][j] = min(dp[i][j], dp[m - 1][j - 1] + unique);
                }
            }
        }

        return dp[n][k];
    }
};