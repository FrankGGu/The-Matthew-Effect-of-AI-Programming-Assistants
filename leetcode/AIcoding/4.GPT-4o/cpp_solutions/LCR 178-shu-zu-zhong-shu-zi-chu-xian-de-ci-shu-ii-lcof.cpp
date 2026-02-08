class Solution {
public:
    double trainingPlan(int n, int m, vector<int>& A, vector<int>& B) {
        vector<double> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + A[i - 1];
            for (int j = 1; j <= m && j <= i; ++j) {
                dp[i] = max(dp[i], dp[i - j] + B[j - 1]);
            }
        }
        return dp[n] / n;
    }
};