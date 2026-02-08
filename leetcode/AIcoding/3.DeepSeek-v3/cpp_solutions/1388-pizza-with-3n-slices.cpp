class Solution {
public:
    int maxSizeSlices(vector<int>& slices) {
        int n = slices.size();
        int k = n / 3;
        return max(helper(slices, 0, n - 2, k), helper(slices, 1, n - 1, k));
    }

private:
    int helper(vector<int>& slices, int start, int end, int k) {
        int n = end - start + 1;
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= k; ++j) {
                if (i == 1) {
                    dp[i][j] = slices[start];
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i - 2][j - 1] + slices[start + i - 1]);
                }
            }
        }

        return dp[n][k];
    }
};