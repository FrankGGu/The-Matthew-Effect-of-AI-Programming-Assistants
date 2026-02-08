#include <vector>
#include <algorithm> // Required for std::max

class Solution {
public:
    int rows;
    int cols;
    std::vector<std::vector<int>> dp;
    std::vector<std::vector<int>> matrix_ref; // Renamed to avoid shadowing parameter

    int dr[4] = {-1, 1, 0, 0};
    int dc[4] = {0, 0, -1, 1};

    int dfs(int r, int c) {
        if (dp[r][c] != 0) {
            return dp[r][c];
        }

        int maxLen = 1;

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && matrix_ref[nr][nc] > matrix_ref[r][c]) {
                maxLen = std::max(maxLen, 1 + dfs(nr, nc));
            }
        }

        dp[r][c] = maxLen;
        return maxLen;
    }

    int longestIncreasingPath(std::vector<std::vector<int>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) {
            return 0;
        }

        this->matrix_ref = matrix;
        rows = matrix.size();
        cols = matrix[0].size();
        dp.assign(rows, std::vector<int>(cols, 0));

        int overallMax = 0;
        for (int r = 0; r < rows; ++r) {
            for (int c = 0; c < cols; ++c) {
                overallMax = std::max(overallMax, dfs(r, c));
            }
        }

        return overallMax;
    }
};