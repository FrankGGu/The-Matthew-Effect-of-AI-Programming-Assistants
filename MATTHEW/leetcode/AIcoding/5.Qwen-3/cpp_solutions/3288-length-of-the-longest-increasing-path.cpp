#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int longestIncreasingPath(const vector<vector<int>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) return 0;
        int rows = matrix.size();
        int cols = matrix[0].size();
        vector<vector<int>> dp(rows, vector<int>(cols, 0));
        int maxLen = 0;
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                maxLen = max(maxLen, dfs(matrix, dp, i, j));
            }
        }
        return maxLen;
    }

private:
    int dfs(const vector<vector<int>>& matrix, vector<vector<int>>& dp, int i, int j) {
        if (dp[i][j] != 0) return dp[i][j];
        int rows = matrix.size();
        int cols = matrix[0].size();
        int maxPath = 1;
        int dx[] = {-1, 1, 0, 0};
        int dy[] = {0, 0, -1, 1};
        for (int k = 0; k < 4; ++k) {
            int x = i + dx[k];
            int y = j + dy[k];
            if (x >= 0 && x < rows && y >= 0 && y < cols && matrix[x][y] > matrix[i][j]) {
                int path = 1 + dfs(matrix, dp, x, y);
                maxPath = max(maxPath, path);
            }
        }
        dp[i][j] = maxPath;
        return maxPath;
    }
};