class Solution {
public:
    int minimumDamage(vector<int>& A, vector<int>& B) {
        int n = A.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < i; ++j) {
                dp[i] = min(dp[i], dp[j] + A[j] * B[i - 1]);
            }
        }

        return dp[n];
    }
};