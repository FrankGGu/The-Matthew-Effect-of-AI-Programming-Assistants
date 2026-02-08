class Solution {
public:
    int longestIncreasingPath(vector<vector<int>>& matrix) {
        if (matrix.empty() || matrix[0].empty()) return 0;
        int m = matrix.size(), n = matrix[0].size();
        vector<vector<int>> memo(m, vector<int>(n, 0));
        int res = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                res = max(res, dfs(matrix, memo, i, j));
            }
        }
        return res;
    }

    int dfs(vector<vector<int>>& matrix, vector<vector<int>>& memo, int i, int j) {
        if (memo[i][j] != 0) return memo[i][j];
        int m = matrix.size(), n = matrix[0].size();
        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int maxLen = 1;
        for (auto& dir : dirs) {
            int x = i + dir[0], y = j + dir[1];
            if (x >= 0 && x < m && y >= 0 && y < n && matrix[x][y] > matrix[i][j]) {
                maxLen = max(maxLen, 1 + dfs(matrix, memo, x, y));
            }
        }
        memo[i][j] = maxLen;
        return maxLen;
    }
};