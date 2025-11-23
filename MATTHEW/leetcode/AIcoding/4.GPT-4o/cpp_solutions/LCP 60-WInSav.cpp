class Solution {
public:
    vector<vector<int>> popBubbles(int m, int n, vector<vector<int>>& bubbles) {
        vector<vector<int>> grid(m, vector<int>(n, 0));
        for (const auto& bubble : bubbles) {
            grid[bubble[0]][bubble[1]] = 1;
        }

        vector<int> directions = {0, 1, 0, -1, 0};

        auto inBounds = [&](int x, int y) {
            return x >= 0 && x < m && y >= 0 && y < n;
        };

        function<void(int, int)> dfs = [&](int x, int y) {
            grid[x][y] = 2;
            for (int i = 0; i < 4; ++i) {
                int nx = x + directions[i];
                int ny = y + directions[i + 1];
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

        vector<vector<int>> result;
        for (const auto& bubble : bubbles) {
            int x = bubble[0], y = bubble[1];
            grid[x][y] = 0;
            if (x == 0 || (inBounds(x - 1, y) && grid[x - 1][y] == 2)) {
                dfs(x, y);
            }
            result.push_back({x, y, grid[x][y] == 2 ? 1 : 0});
        }

        return result;
    }
};