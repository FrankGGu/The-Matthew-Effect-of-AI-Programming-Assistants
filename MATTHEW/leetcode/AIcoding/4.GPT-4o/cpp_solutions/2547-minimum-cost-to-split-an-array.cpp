class Solution {
public:
    int minCost(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, INT_MAX));
        vector<int> freq(n + 1, 0);

        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= k; ++j) {
                int uniqueCount = 0;
                freq.assign(n + 1, 0);
                for (int m = i; m >= 1; --m) {
                    if (freq[nums[m - 1]] == 0) uniqueCount++;
                    freq[nums[m - 1]]++;
                    dp[i][j] = min(dp[i][j], dp[m - 1][j - 1] + uniqueCount);
                }
            }
        }

        return dp[n][k];
    }
};