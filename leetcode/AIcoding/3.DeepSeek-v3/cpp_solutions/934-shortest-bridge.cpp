class Solution {
public:
    int shortestBridge(vector<vector<int>>& grid) {
        int n = grid.size();
        queue<pair<int, int>> q;
        bool found = false;

        for (int i = 0; i < n && !found; ++i) {
            for (int j = 0; j < n && !found; ++j) {
                if (grid[i][j] == 1) {
                    dfs(grid, i, j, q);
                    found = true;
                }
            }
        }

        int steps = 0;
        vector<int> dirs = {0, 1, 0, -1, 0};

        while (!q.empty()) {
            int size = q.size();
            while (size--) {
                auto [x, y] = q.front();
                q.pop();
                for (int k = 0; k < 4; ++k) {
                    int nx = x + dirs[k];
                    int ny = y + dirs[k + 1];
                    if (nx >= 0 && ny >= 0 && nx < n && ny < n) {
                        if (grid[nx][ny] == 1) {
                            return steps;
                        }
                        if (grid[nx][ny] == 0) {
                            grid[nx][ny] = 2;
                            q.push({nx, ny});
                        }
                    }
                }
            }
            steps++;
        }
        return -1;
    }

    void dfs(vector<vector<int>>& grid, int i, int j, queue<pair<int, int>>& q) {
        if (i < 0 || j < 0 || i >= grid.size() || j >= grid.size() || grid[i][j] != 1) {
            return;
        }
        grid[i][j] = 2;
        q.push({i, j});
        dfs(grid, i + 1, j, q);
        dfs(grid, i - 1, j, q);
        dfs(grid, i, j + 1, q);
        dfs(grid, i, j - 1, q);
    }
};