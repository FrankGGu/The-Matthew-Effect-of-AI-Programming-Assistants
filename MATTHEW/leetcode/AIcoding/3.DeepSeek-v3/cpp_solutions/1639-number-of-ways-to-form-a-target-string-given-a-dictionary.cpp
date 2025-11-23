class Solution {
public:
    int numWays(vector<string>& words, string target) {
        const int MOD = 1e9 + 7;
        int m = words[0].size();
        int n = target.size();
        if (n > m) return 0;

        vector<vector<long>> freq(m, vector<long>(26, 0));
        for (const string& word : words) {
            for (int i = 0; i < m; ++i) {
                freq[i][word[i] - 'a']++;
            }
        }

        vector<vector<long>> dp(n + 1, vector<long>(m + 1, 0));
        dp[0][0] = 1;

        for (int i = 0; i <= n; ++i) {
            for (int j = 0; j <= m; ++j) {
                if (i == 0 && j == 0) continue;
                if (i == 0) {
                    dp[i][j] = 1;
                } else if (j == 0) {
                    dp[i][j] = 0;
                } else {
                    dp[i][j] = dp[i][j - 1];
                    if (i <= j) {
                        char c = target[i - 1];
                        long cnt = freq[j - 1][c - 'a'];
                        dp[i][j] = (dp[i][j] + dp[i - 1][j - 1] * cnt) % MOD;
                    }
                }
            }
        }

        return dp[n][m];
    }
};