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
        int maxPath = 0;

        function<int(int, int)> dfs = [&](int row, int col) {
            if (dp[row][col] != 0) {
                return dp[row][col];
            }

            int maxLen = 1;
            int directions[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

            for (auto& dir : directions) {
                int newRow = row + dir[0];
                int newCol = col + dir[1];

                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols &&
                    matrix[newRow][newCol] > matrix[row][col]) {
                    maxLen = max(maxLen, 1 + dfs(newRow, newCol));
                }
            }

            dp[row][col] = maxLen;
            return maxLen;
        };

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                maxPath = max(maxPath, dfs(i, j));
            }
        }

        return maxPath;
    }
};