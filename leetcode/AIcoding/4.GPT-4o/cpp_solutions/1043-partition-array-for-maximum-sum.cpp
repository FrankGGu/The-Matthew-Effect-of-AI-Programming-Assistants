class Solution {
public:
    int maxSumAfterPartitioning(vector<int>& arr, int k) {
        int n = arr.size();
        vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            int maxNum = 0;
            for (int j = 1; j <= min(k, i); ++j) {
                maxNum = max(maxNum, arr[i - j]);
                dp[i] = max(dp[i], dp[i - j] + maxNum * j);
            }
        }

        return dp[n];
    }
};