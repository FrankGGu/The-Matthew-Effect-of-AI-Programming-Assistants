class Solution {
public:
    int ways(vector<string>& pizza, int k) {
        const int MOD = 1e9 + 7;
        int rows = pizza.size();
        int cols = pizza[0].size();
        vector<vector<int>> prefix(rows + 1, vector<int>(cols + 1, 0));
        for (int i = rows - 1; i >= 0; --i) {
            for (int j = cols - 1; j >= 0; --j) {
                prefix[i][j] = prefix[i + 1][j] + prefix[i][j + 1] - prefix[i + 1][j + 1] + (pizza[i][j] == 'A');
            }
        }

        vector<vector<vector<int>>> dp(k, vector<vector<int>>(rows, vector<int>(cols, 0)));
        dp[0][0][0] = 1;

        for (int cut = 1; cut < k; ++cut) {
            for (int i = 0; i < rows; ++i) {
                for (int j = 0; j < cols; ++j) {
                    if (dp[cut - 1][i][j] == 0) continue;
                    for (int ni = i + 1; ni < rows; ++ni) {
                        if (prefix[i][j] - prefix[ni][j] > 0) {
                            dp[cut][ni][j] = (dp[cut][ni][j] + dp[cut - 1][i][j]) % MOD;
                        }
                    }
                    for (int nj = j + 1; nj < cols; ++nj) {
                        if (prefix[i][j] - prefix[i][nj] > 0) {
                            dp[cut][i][nj] = (dp[cut][i][nj] + dp[cut - 1][i][j]) % MOD;
                        }
                    }
                }
            }
        }

        int res = 0;
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (prefix[i][j] > 0) {
                    res = (res + dp[k - 1][i][j]) % MOD;
                }
            }
        }
        return res;
    }
};