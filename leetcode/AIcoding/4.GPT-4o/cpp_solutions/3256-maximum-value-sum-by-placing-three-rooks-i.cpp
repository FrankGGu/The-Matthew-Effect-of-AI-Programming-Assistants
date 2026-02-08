class Solution {
public:
    int maxValue(char** grid, int gridSize, int* gridColSize) {
        int rows = gridSize, cols = gridColSize[0];
        vector<vector<int>> dp(rows + 1, vector<int>(cols + 1, 0));
        for (int i = 1; i <= rows; ++i) {
            for (int j = 1; j <= cols; ++j) {
                dp[i][j] = dp[i - 1][j] + dp[i][j - 1] - dp[i - 1][j - 1] + (grid[i - 1][j - 1] == 'R' ? 1 : 0);
            }
        }
        int maxSum = 0;
        for (int r1 = 0; r1 < rows; ++r1) {
            for (int c1 = 0; c1 < cols; ++c1) {
                for (int r2 = r1 + 1; r2 < rows; ++r2) {
                    for (int c2 = 0; c2 < cols; ++c2) {
                        for (int r3 = r2 + 1; r3 < rows; ++r3) {
                            for (int c3 = 0; c3 < cols; ++c3) {
                                int currentSum = dp[r1 + 1][c1 + 1] + dp[r2 + 1][c2 + 1] + dp[r3 + 1][c3 + 1];
                                currentSum -= dp[r1 + 1][c2 + 1];
                                currentSum -= dp[r1 + 1][c3 + 1];
                                currentSum -= dp[r2 + 1][c3 + 1];
                                currentSum -= dp[r2 + 1][c1 + 1];
                                currentSum -= dp[r3 + 1][c1 + 1];
                                currentSum -= dp[r3 + 1][c2 + 1];
                                currentSum += dp[r1 + 1][c1 + 1];
                                currentSum += dp[r2 + 1][c2 + 1];
                                currentSum += dp[r3 + 1][c3 + 1];
                                maxSum = max(maxSum, currentSum);
                            }
                        }
                    }
                }
            }
        }
        return maxSum;
    }
};