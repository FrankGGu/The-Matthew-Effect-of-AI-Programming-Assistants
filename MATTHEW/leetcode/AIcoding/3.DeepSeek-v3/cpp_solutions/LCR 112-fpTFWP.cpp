#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int longestIncreasingPath(vector<vector<int>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) return 0;
        rows = matrix.size();
        cols = matrix[0].size();
        dp = vector<vector<int>>(rows, vector<int>(cols, 0));
        int maxPath = 0;
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                maxPath = max(maxPath, dfs(matrix, i, j));
            }
        }
        return maxPath;
    }

private:
    int rows, cols;
    vector<vector<int>> dp;
    vector<int> dirs = {0, 1, 0, -1, 0};

    int dfs(vector<vector<int>>& matrix, int i, int j) {
        if (dp[i][j] != 0) return dp[i][j];
        int maxLen = 1;
        for (int k = 0; k < 4; ++k) {
            int x = i + dirs[k];
            int y = j + dirs[k + 1];
            if (x >= 0 && x < rows && y >= 0 && y < cols && matrix[x][y] > matrix[i][j]) {
                maxLen = max(maxLen, 1 + dfs(matrix, x, y));
            }
        }
        dp[i][j] = maxLen;
        return maxLen;
    }
};