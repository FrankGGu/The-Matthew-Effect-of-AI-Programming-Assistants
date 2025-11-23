class Solution {
public:
    vector<int> pathsWithMaxScore(vector<vector<int>>& board) {
        int n = board.size(), m = board[0].size();
        vector<vector<long long>> dp(n, vector<long long>(m, 0));
        vector<vector<int>> count(n, vector<int>(m, 0));
        long long mod = 1e9 + 7;

        for (int i = n - 1; i >= 0; --i) {
            for (int j = m - 1; j >= 0; --j) {
                if (board[i][j] == -1) continue;
                long long score = (i == n - 1 && j == m - 1) ? 0 : board[i][j];
                if (i + 1 < n) {
                    if (dp[i + 1][j] + score > dp[i][j]) {
                        dp[i][j] = dp[i + 1][j] + score;
                        count[i][j] = count[i + 1][j];
                    } else if (dp[i + 1][j] + score == dp[i][j]) {
                        count[i][j] = (count[i][j] + count[i + 1][j]) % mod;
                    }
                }
                if (j + 1 < m) {
                    if (dp[i][j + 1] + score > dp[i][j]) {
                        dp[i][j] = dp[i][j + 1] + score;
                        count[i][j] = count[i][j + 1];
                    } else if (dp[i][j + 1] + score == dp[i][j]) {
                        count[i][j] = (count[i][j] + count[i][j + 1]) % mod;
                    }
                }
                if (i == n - 1 && j == m - 1) {
                    count[i][j] = 1;
                }
            }
        }

        if (dp[0][0] < 0) return {0, 0};
        return {static_cast<int>(dp[0][0] % mod), count[0][0]};
    }
};