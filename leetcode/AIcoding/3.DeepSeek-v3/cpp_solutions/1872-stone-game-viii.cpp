class Solution {
public:
    int stoneGameVIII(vector<int>& stones) {
        int n = stones.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + stones[i];
        }

        vector<int> dp(n, 0);
        dp[n - 1] = prefix[n];

        for (int i = n - 2; i >= 1; --i) {
            dp[i] = max(dp[i + 1], prefix[i + 1] - dp[i + 1]);
        }

        return dp[1];
    }
};