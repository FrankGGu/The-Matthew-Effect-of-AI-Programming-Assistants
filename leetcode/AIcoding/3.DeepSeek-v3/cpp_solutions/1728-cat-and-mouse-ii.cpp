class Solution {
public:
    bool canMouseWin(vector<string>& grid, int catJump, int mouseJump) {
        int m = grid.size(), n = grid[0].size();
        int mouse_pos = 0, cat_pos = 0, food_pos = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 'M') mouse_pos = i * n + j;
                else if (grid[i][j] == 'C') cat_pos = i * n + j;
                else if (grid[i][j] == 'F') food_pos = i * n + j;
            }
        }

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int dp[8][8][8][8][2];
        memset(dp, -1, sizeof(dp));

        function<int(int, int, int, int, int)> dfs = [&](int mx, int my, int cx, int cy, int turn) {
            if (turn >= 128) return 0;
            if (mx == cx && my == cy) return 0;
            if (mx == food_pos / n && my == food_pos % n) return 1;
            if (cx == food_pos / n && cy == food_pos % n) return 0;

            int &res = dp[mx][my][cx][cy][turn % 2];
            if (res != -1) return res;

            if (turn % 2 == 0) {
                for (auto &d : dirs) {
                    for (int j = 0; j <= mouseJump; ++j) {
                        int nmx = mx + d[0] * j;
                        int nmy = my + d[1] * j;
                        if (nmx < 0 || nmx >= m || nmy < 0 || nmy >= n || grid[nmx][nmy] == '#') break;
                        if (dfs(nmx, nmy, cx, cy, turn + 1) == 1) return res = 1;
                    }
                }
                return res = 0;
            } else {
                for (auto &d : dirs) {
                    for (int j = 0; j <= catJump; ++j) {
                        int ncx = cx + d[0] * j;
                        int ncy = cy + d[1] * j;
                        if (ncx < 0 || ncx >= m || ncy < 0 || ncy >= n || grid[ncx][ncy] == '#') break;
                        if (dfs(mx, my, ncx, ncy, turn + 1) == 0) return res = 0;
                    }
                }
                return res = 1;
            }
        };

        return dfs(mouse_pos / n, mouse_pos % n, cat_pos / n, cat_pos % n, 0);
    }
};