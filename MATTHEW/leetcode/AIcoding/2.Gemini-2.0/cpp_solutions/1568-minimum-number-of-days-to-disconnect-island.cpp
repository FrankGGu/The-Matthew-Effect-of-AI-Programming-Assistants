#include <vector>

using namespace std;

class Solution {
public:
    int minDays(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        auto count_islands = [&](const vector<vector<int>>& g) {
            int islands = 0;
            vector<vector<bool>> visited(m, vector<bool>(n, false));

            function<void(int, int)> dfs = [&](int r, int c) {
                if (r < 0 || r >= m || c < 0 || c >= n || g[r][c] == 0 || visited[r][c]) {
                    return;
                }
                visited[r][c] = true;
                dfs(r + 1, c);
                dfs(r - 1, c);
                dfs(r, c + 1);
                dfs(r, c - 1);
            };

            for (int i = 0; i < m; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (g[i][j] == 1 && !visited[i][j]) {
                        islands++;
                        dfs(i, j);
                    }
                }
            }
            return islands;
        };

        int initial_islands = count_islands(grid);

        if (initial_islands == 0 || initial_islands > 1) {
            return 0;
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    vector<vector<int>> temp_grid = grid;
                    temp_grid[i][j] = 0;
                    if (count_islands(temp_grid) != 1) {
                        return 1;
                    }
                }
            }
        }

        return 2;
    }
};