class Solution {
public:
    int countArtifacts(int n, vector<vector<int>>& artifacts) {
        vector<vector<int>> grid(n, vector<int>(n, 0));
        for (const auto& artifact : artifacts) {
            int x = artifact[0];
            int y = artifact[1];
            grid[x][y] = 1;
        }

        int count = 0;
        vector<vector<bool>> visited(n, vector<bool>(n, false));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1 && !visited[i][j]) {
                    count++;
                    dfs(grid, visited, i, j, n);
                }
            }
        }

        return count;
    }

    void dfs(vector<vector<int>>& grid, vector<vector<bool>>& visited, int x, int y, int n) {
        if (x < 0 || x >= n || y < 0 || y >= n || visited[x][y] || grid[x][y] == 0) {
            return;
        }
        visited[x][y] = true;
        dfs(grid, visited, x + 1, y, n);
        dfs(grid, visited, x - 1, y, n);
        dfs(grid, visited, x, y + 1, n);
        dfs(grid, visited, x, y - 1, n);
    }
};