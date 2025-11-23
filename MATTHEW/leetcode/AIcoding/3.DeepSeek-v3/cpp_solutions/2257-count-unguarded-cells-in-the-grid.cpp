class Solution {
public:
    int countUnguarded(int m, int n, vector<vector<int>>& guards, vector<vector<int>>& walls) {
        vector<vector<int>> grid(m, vector<int>(n, 0));
        for (auto& g : guards) {
            grid[g[0]][g[1]] = 1;
        }
        for (auto& w : walls) {
            grid[w[0]][w[1]] = 2;
        }

        vector<vector<bool>> guarded(m, vector<bool>(n, false));
        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        for (auto& g : guards) {
            int x = g[0], y = g[1];
            for (int k = 0; k < 4; ++k) {
                int dx = dirs[k][0], dy = dirs[k][1];
                int nx = x + dx, ny = y + dy;
                while (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    if (grid[nx][ny] == 1 || grid[nx][ny] == 2) break;
                    guarded[nx][ny] = true;
                    nx += dx;
                    ny += dy;
                }
            }
        }

        int res = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0 && !guarded[i][j]) {
                    res++;
                }
            }
        }
        return res;
    }
};