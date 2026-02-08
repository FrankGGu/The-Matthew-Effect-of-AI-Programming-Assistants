class Solution {
public:
    double largestSumOfAverages(vector<int>& A, int K) {
        int N = A.size();
        vector<double> dp(N + 1, 0);
        vector<double> prefix(N + 1, 0);

        for (int i = 1; i <= N; ++i) {
            prefix[i] = prefix[i - 1] + A[i - 1];
        }

        for (int k = 1; k <= K; ++k) {
            vector<double> new_dp(N + 1, 0);
            for (int i = k; i <= N; ++i) {
                for (int j = k - 1; j < i; ++j) {
                    new_dp[i] = max(new_dp[i], dp[j] + (prefix[i] - prefix[j]) / (i - j));
                }
            }
            dp = new_dp;
        }

        return dp[N];
    }
};