class Solution {
public:
    int getLengthOfOptimalCompression(string s, int k) {
        int n = s.size();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, n));
        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k; ++j) {
                if (j > 0) {
                    dp[i][j] = dp[i - 1][j - 1];
                }
                int cnt = 0, del = 0;
                for (int l = i; l >= 1; --l) {
                    if (s[l - 1] == s[i - 1]) {
                        cnt++;
                    } else {
                        del++;
                    }
                    if (del > j) break;
                    int len = 0;
                    if (cnt >= 100) len = 4;
                    else if (cnt >= 10) len = 3;
                    else if (cnt >= 2) len = 2;
                    else len = 1;
                    dp[i][j] = min(dp[i][j], dp[l - 1][j - del] + len);
                }
            }
        }
        return dp[n][k];
    }
};