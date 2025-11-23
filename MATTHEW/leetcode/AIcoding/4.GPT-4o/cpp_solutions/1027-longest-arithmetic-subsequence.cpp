class Solution {
public:
    int longestArithSeqLength(vector<int>& A) {
        int n = A.size();
        if (n <= 2) return n;

        vector<unordered_map<int, int>> dp(n);
        int maxLength = 2;

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                int diff = A[i] - A[j];
                dp[i][diff] = max(dp[i][diff], dp[j][diff] + 1);
                maxLength = max(maxLength, dp[i][diff] + 1);
            }
        }

        return maxLength;
    }
};