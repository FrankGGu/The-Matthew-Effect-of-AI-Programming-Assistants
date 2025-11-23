class Solution {
public:
    int longestIncreasingPath(vector<vector<int>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) return 0;
        int m = matrix.size(), n = matrix[0].size();
        vector<vector<int>> dp(m, vector<int>(n, -1));
        int longestPath = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                longestPath = max(longestPath, dfs(matrix, dp, i, j));
            }
        }

        return longestPath;
    }

private:
    int dfs(vector<vector<int>>& matrix, vector<vector<int>>& dp, int x, int y) {
        if (dp[x][y] != -1) return dp[x][y];

        int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        dp[x][y] = 1;

        for (auto& dir : directions) {
            int newX = x + dir[0], newY = y + dir[1];
            if (newX >= 0 && newX < matrix.size() && newY >= 0 && newY < matrix[0].size() && matrix[newX][newY] > matrix[x][y]) {
                dp[x][y] = max(dp[x][y], 1 + dfs(matrix, dp, newX, newY));
            }
        }

        return dp[x][y];
    }
};