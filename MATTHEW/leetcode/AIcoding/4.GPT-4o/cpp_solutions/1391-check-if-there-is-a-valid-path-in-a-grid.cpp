class Solution {
public:
    bool hasValidPath(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        return dfs(0, 0, m, n, grid, visited);
    }

private:
    bool dfs(int x, int y, int m, int n, vector<vector<int>>& grid, vector<vector<bool>>& visited) {
        if (x == m - 1 && y == n - 1) return true;
        if (visited[x][y]) return false;
        visited[x][y] = true;

        switch (grid[x][y]) {
            case 1:
                if (y + 1 < n && grid[x][y + 1] == 1) {
                    if (dfs(x, y + 1, m, n, grid, visited)) return true;
                }
                if (x + 1 < m && grid[x + 1][y] == 2) {
                    if (dfs(x + 1, y, m, n, grid, visited)) return true;
                }
                break;
            case 2:
                if (x + 1 < m && grid[x + 1][y] == 1) {
                    if (dfs(x + 1, y, m, n, grid, visited)) return true;
                }
                if (y + 1 < n && grid[x][y + 1] == 3) {
                    if (dfs(x, y + 1, m, n, grid, visited)) return true;
                }
                break;
            case 3:
                if (y > 0 && grid[x][y - 1] == 1) {
                    if (dfs(x, y - 1, m, n, grid, visited)) return true;
                }
                if (x + 1 < m && grid[x + 1][y] == 2) {
                    if (dfs(x + 1, y, m, n, grid, visited)) return true;
                }
                break;
            case 4:
                if (x > 0 && grid[x - 1][y] == 2) {
                    if (dfs(x - 1, y, m, n, grid, visited)) return true;
                }
                if (y + 1 < n && grid[x][y + 1] == 3) {
                    if (dfs(x, y + 1, m, n, grid, visited)) return true;
                }
                break;
            case 5:
                if (x > 0 && grid[x - 1][y] == 2) {
                    if (dfs(x - 1, y, m, n, grid, visited)) return true;
                }
                if (y > 0 && grid[x][y - 1] == 1) {
                    if (dfs(x, y - 1, m, n, grid, visited)) return true;
                }
                break;
            case 6:
                if (y > 0 && grid[x][y - 1] == 1) {
                    if (dfs(x, y - 1, m, n, grid, visited)) return true;
                }
                if (x > 0 && grid[x - 1][y] == 2) {
                    if (dfs(x - 1, y, m, n, grid, visited)) return true;
                }
                break;
        }

        return false;
    }
};