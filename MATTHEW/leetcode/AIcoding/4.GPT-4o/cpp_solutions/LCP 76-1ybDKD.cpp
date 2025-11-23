class Solution {
public:
    int findKnightPosition(int n, int k) {
        if (k == 0) return n * n; // base case when no moves are made
        vector<vector<int>> dp(n, vector<int>(n, 0));
        dp[0][0] = 1; // starting position

        for (int move = 0; move < k; move++) {
            vector<vector<int>> new_dp(n, vector<int>(n, 0));
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (dp[i][j] > 0) {
                        if (i + 2 < n && j + 1 < n) new_dp[i + 2][j + 1] += dp[i][j];
                        if (i + 2 < n && j - 1 >= 0) new_dp[i + 2][j - 1] += dp[i][j];
                        if (i - 2 >= 0 && j + 1 < n) new_dp[i - 2][j + 1] += dp[i][j];
                        if (i - 2 >= 0 && j - 1 >= 0) new_dp[i - 2][j - 1] += dp[i][j];
                        if (i + 1 < n && j + 2 < n) new_dp[i + 1][j + 2] += dp[i][j];
                        if (i + 1 < n && j - 2 >= 0) new_dp[i + 1][j - 2] += dp[i][j];
                        if (i - 1 >= 0 && j + 2 < n) new_dp[i - 1][j + 2] += dp[i][j];
                        if (i - 1 >= 0 && j - 2 >= 0) new_dp[i - 1][j - 2] += dp[i][j];
                    }
                }
            }
            dp = new_dp;
        }

        int total_positions = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                total_positions += dp[i][j];
            }
        }
        return total_positions;
    }
};