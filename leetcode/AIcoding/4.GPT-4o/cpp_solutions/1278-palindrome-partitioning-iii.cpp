class Solution {
public:
    int palindromePartition(string s, int k) {
        int n = s.size();
        vector<vector<int>> dp(n, vector<int>(n, 0));
        for (int i = 0; i < n; i++) {
            for (int j = i; j >= 0; j--) {
                dp[j][i] = (s[j] != s[i]) + (j < i ? dp[j + 1][i - 1] : 0);
            }
        }

        vector<vector<int>> cuts(n + 1, vector<int>(k + 1, INT_MAX));
        cuts[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= min(i, k); j++) {
                for (int p = 0; p < i; p++) {
                    cuts[i][j] = min(cuts[i][j], cuts[p][j - 1] + dp[p][i - 1]);
                }
            }
        }

        return cuts[n][k];
    }
};