class Solution {
public:
    vector<int> hitBricks(vector<vector<int>>& grid, vector<vector<int>>& hits) {
        int m = grid.size(), n = grid[0].size();
        vector<int> result(hits.size(), 0);

        for (auto& hit : hits) {
            grid[hit[0]][hit[1]]--;
        }

        vector<vector<int>> directions = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};

        auto inBounds = [&](int x, int y) {
            return x >= 0 && x < m && y >= 0 && y < n;
        };

        function<void(int, int)> dfs = [&](int x, int y) {
            grid[x][y] = 2;
            for (auto& dir : directions) {
                int nx = x + dir[0], ny = y + dir[1];
                if (inBounds(nx, ny) && grid[nx][ny] == 1) {
                    dfs(nx, ny);
                }
            }
        };

        for (int j = 0; j < n; ++j) {
            if (grid[0][j] == 1) {
                dfs(0, j);
            }
        }

        for (int i = hits.size() - 1; i >= 0; --i) {
            auto& hit = hits[i];
            int x = hit[0], y = hit[1];
            if (grid[x][y] == 0) {
                grid[x][y] = 1;
                if (x == 0) {
                    dfs(x, y);
                } else {
                    for (auto& dir : directions) {
                        int nx = x + dir[0], ny = y + dir[1];
                        if (inBounds(nx, ny) && grid[nx][ny] == 2) {
                            dfs(x, y);
                            break;
                        }
                    }
                }
            }
            result[i] = max(0, countBricks(grid) - 1);
        }

        return result;
    }

    int countBricks(vector<vector<int>>& grid) {
        int count = 0;
        for (auto& row : grid) {
            for (auto& cell : row) {
                if (cell == 2) {
                    count++;
                }
            }
        }
        return count;
    }
};