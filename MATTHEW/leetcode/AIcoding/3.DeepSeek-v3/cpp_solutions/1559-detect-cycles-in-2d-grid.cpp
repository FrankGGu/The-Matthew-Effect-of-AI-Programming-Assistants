class Solution {
public:
    bool containsCycle(vector<vector<char>>& grid) {
        int m = grid.size();
        if (m == 0) return false;
        int n = grid[0].size();
        vector<vector<bool>> visited(m, vector<bool>(n, false));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (!visited[i][j]) {
                    if (dfs(grid, visited, i, j, -1, -1, grid[i][j])) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

private:
    bool dfs(vector<vector<char>>& grid, vector<vector<bool>>& visited, int i, int j, int pi, int pj, char target) {
        if (i < 0 || i >= grid.size() || j < 0 || j >= grid[0].size() || grid[i][j] != target) {
            return false;
        }
        if (visited[i][j]) {
            return true;
        }
        visited[i][j] = true;

        vector<pair<int, int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        for (auto& dir : directions) {
            int ni = i + dir.first;
            int nj = j + dir.second;
            if (ni == pi && nj == pj) continue;
            if (dfs(grid, visited, ni, nj, i, j, target)) {
                return true;
            }
        }
        return false;
    }
};