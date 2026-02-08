class Solution {
public:
    int separateSquares(vector<int>& squares) {
        int n = squares.size();
        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= i; ++j) {
                dp[i] = max(dp[i], dp[i - j] + squares[j - 1]);
            }
        }
        return dp[n];
    }
};