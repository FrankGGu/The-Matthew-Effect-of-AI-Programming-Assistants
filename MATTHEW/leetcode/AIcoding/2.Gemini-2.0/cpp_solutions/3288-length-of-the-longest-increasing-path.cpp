#include <vector>

using namespace std;

class Solution {
public:
    int longestIncreasingPath(vector<vector<int>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) {
            return 0;
        }

        int rows = matrix.size();
        int cols = matrix[0].size();
        vector<vector<int>> dp(rows, vector<int>(cols, 0));
        int max_len = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                max_len = max(max_len, dfs(matrix, i, j, dp));
            }
        }

        return max_len;
    }

private:
    int dfs(vector<vector<int>>& matrix, int row, int col, vector<vector<int>>& dp) {
        if (dp[row][col] != 0) {
            return dp[row][col];
        }

        int rows = matrix.size();
        int cols = matrix[0].size();
        int max_len = 1;
        int directions[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        for (auto& dir : directions) {
            int new_row = row + dir[0];
            int new_col = col + dir[1];

            if (new_row >= 0 && new_row < rows && new_col >= 0 && new_col < cols &&
                matrix[new_row][new_col] > matrix[row][col]) {
                max_len = max(max_len, 1 + dfs(matrix, new_row, new_col, dp));
            }
        }

        dp[row][col] = max_len;
        return max_len;
    }
};