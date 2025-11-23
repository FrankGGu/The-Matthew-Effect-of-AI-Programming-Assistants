class Solution {
public:
    double champagneTower(int poured, int query_row, int query_glass) {
        vector<vector<double>> dp(101, vector<double>(101, 0.0));
        dp[0][0] = poured;

        for (int r = 0; r <= query_row; r++) {
            for (int g = 0; g <= r; g++) {
                if (dp[r][g] > 1.0) {
                    double overflow = dp[r][g] - 1.0;
                    dp[r][g] = 1.0;
                    dp[r + 1][g] += overflow / 2;
                    dp[r + 1][g + 1] += overflow / 2;
                }
            }
        }

        return dp[query_row][query_glass];
    }
};