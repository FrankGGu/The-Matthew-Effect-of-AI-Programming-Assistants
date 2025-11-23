#include <vector>
#include <algorithm>

class Solution {
public:
    int rows;
    int cols;
    std::vector<std::vector<int>> memo;
    int dirs[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    int dfs(const std::vector<std::vector<int>>& matrix, int r, int c) {
        if (memo[r][c] != 0) {
            return memo[r][c];
        }

        int max_len = 1;

        for (int i = 0; i < 4; ++i) {
            int nr = r + dirs[i][0];
            int nc = c + dirs[i][1];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && matrix[nr][nc] > matrix[r][c]) {
                max_len = std::max(max_len, 1 + dfs(matrix, nr, nc));
            }
        }

        memo[r][c] = max_len;
        return max_len;
    }

    int longestIncreasingPath(const std::vector<std::vector<int>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) {
            return 0;
        }

        rows = matrix.size();
        cols = matrix[0].size();
        memo.assign(rows, std::vector<int>(cols, 0));

        int overall_max_len = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                overall_max_len = std::max(overall_max_len, dfs(matrix, i, j));
            }
        }

        return overall_max_len;
    }
};