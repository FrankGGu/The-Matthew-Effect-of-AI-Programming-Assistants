#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxScore(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        vector<vector<int>> dp(rows, vector<int>(cols, 0));

        dp[0][0] = grid[0][0];

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (i == 0 && j == 0) continue;
                int maxVal = 0;
                if (i > 0) maxVal = max(maxVal, dp[i-1][j]);
                if (j > 0) maxVal = max(maxVal, dp[i][j-1]);
                dp[i][j] = maxVal + grid[i][j];
            }
        }

        return dp[rows-1][cols-1];
    }
};