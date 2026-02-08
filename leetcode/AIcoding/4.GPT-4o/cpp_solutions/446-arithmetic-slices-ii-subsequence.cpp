class Solution {
public:
    int numberOfArithmeticSlices(vector<int>& A) {
        int n = A.size();
        if (n < 3) return 0;

        vector<unordered_map<long long, int>> dp(n);
        int total = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                long long diff = (long long)A[i] - A[j];
                if (dp[j].count(diff)) {
                    dp[i][diff] += dp[j][diff];
                    total += dp[j][diff];
                }
                dp[i][diff] += 1;
            }
        }

        return total;
    }
};