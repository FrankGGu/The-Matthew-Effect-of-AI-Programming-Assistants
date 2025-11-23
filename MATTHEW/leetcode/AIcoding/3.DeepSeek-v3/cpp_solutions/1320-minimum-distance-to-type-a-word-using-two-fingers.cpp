class Solution {
public:
    int minimumDistance(string word) {
        int n = word.size();
        if (n <= 2) return 0;

        vector<vector<vector<int>>> dp(n, vector<vector<int>>(26, vector<int>(26, INT_MAX)));

        int firstChar = word[0] - 'A';
        for (int i = 0; i < 26; ++i) {
            for (int j = 0; j < 26; ++j) {
                if (i == firstChar || j == firstChar) {
                    dp[0][i][j] = 0;
                }
            }
        }

        for (int k = 1; k < n; ++k) {
            int curr = word[k] - 'A';
            int prev = word[k-1] - 'A';

            for (int i = 0; i < 26; ++i) {
                for (int j = 0; j < 26; ++j) {
                    if (dp[k-1][i][j] != INT_MAX) {
                        if (i == prev) {
                            int dist = abs(curr/6 - i/6) + abs(curr%6 - i%6);
                            dp[k][curr][j] = min(dp[k][curr][j], dp[k-1][i][j] + dist);
                        }
                        if (j == prev) {
                            int dist = abs(curr/6 - j/6) + abs(curr%6 - j%6);
                            dp[k][i][curr] = min(dp[k][i][curr], dp[k-1][i][j] + dist);
                        }
                    }
                }
            }
        }

        int res = INT_MAX;
        for (int i = 0; i < 26; ++i) {
            for (int j = 0; j < 26; ++j) {
                res = min(res, dp[n-1][i][j]);
            }
        }
        return res;
    }
};