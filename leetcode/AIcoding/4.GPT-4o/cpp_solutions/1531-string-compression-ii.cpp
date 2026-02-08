class Solution {
public:
    int getLengthOfOptimalCompression(string s, int k) {
        int n = s.size();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, INT_MAX / 2));
        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k; ++j) {
                int cnt[128] = {0};
                int total = 0;

                for (int l = i; l >= 1; --l) {
                    cnt[s[l - 1]]++;
                    total++;

                    if (cnt[s[l - 1]] == 1) {
                        dp[i][j] = min(dp[i][j], dp[l - 1][j] + 1);
                    } else if (cnt[s[l - 1]] == 2) {
                        dp[i][j] = min(dp[i][j], dp[l - 1][j] + 2);
                    } else if (cnt[s[l - 1]] == 3) {
                        dp[i][j] = min(dp[i][j], dp[l - 1][j] + 2);
                    } else {
                        int len = to_string(cnt[s[l - 1]]).length();
                        dp[i][j] = min(dp[i][j], dp[l - 1][j] + len + 1);
                    }

                    if (j > 0) {
                        dp[i][j] = min(dp[i][j], dp[l - 1][j - 1]);
                    }
                }
            }
        }

        int res = INT_MAX;
        for (int j = 0; j <= k; ++j) {
            res = min(res, dp[n][j]);
        }
        return res;
    }
};