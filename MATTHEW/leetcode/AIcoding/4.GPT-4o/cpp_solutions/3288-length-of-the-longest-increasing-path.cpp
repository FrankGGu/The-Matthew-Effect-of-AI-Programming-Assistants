class Solution {
public:
    int longestIncreasingPath(vector<vector<int>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) return 0;
        int m = matrix.size(), n = matrix[0].size();
        vector<vector<int>> dp(m, vector<int>(n, -1));
        int longest = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                longest = max(longest, dfs(matrix, dp, i, j));
            }
        }
        return longest;
    }

    int dfs(vector<vector<int>>& matrix, vector<vector<int>>& dp, int x, int y) {
        if (dp[x][y] != -1) return dp[x][y];
        int m = matrix.size(), n = matrix[0].size();
        int longest = 1;
        vector<pair<int, int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        for (auto& dir : directions) {
            int nx = x + dir.first, ny = y + dir.second;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && matrix[nx][ny] > matrix[x][y]) {
                longest = max(longest, 1 + dfs(matrix, dp, nx, ny));
            }
        }
        return dp[x][y] = longest;
    }
};