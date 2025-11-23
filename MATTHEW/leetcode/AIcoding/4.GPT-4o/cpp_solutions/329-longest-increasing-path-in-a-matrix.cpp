class Solution {
public:
    int longestIncreasingPath(vector<vector<int>>& matrix) {
        if (matrix.empty()) return 0;
        int m = matrix.size(), n = matrix[0].size();
        vector<vector<int>> dp(m, vector<int>(n, -1));
        int maxLength = 0;

        function<int(int, int)> dfs = [&](int x, int y) {
            if (dp[x][y] != -1) return dp[x][y];
            int length = 1;
            vector<pair<int, int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
            for (auto& dir : directions) {
                int newX = x + dir.first, newY = y + dir.second;
                if (newX >= 0 && newX < m && newY >= 0 && newY < n && matrix[newX][newY] > matrix[x][y]) {
                    length = max(length, 1 + dfs(newX, newY));
                }
            }
            return dp[x][y] = length;
        };

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                maxLength = max(maxLength, dfs(i, j));
            }
        }
        return maxLength;
    }
};