#include <vector>

using namespace std;

class Solution {
public:
    bool containsCycle(vector<vector<char>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<bool>> visited(m, vector<bool>(n, false));

        function<bool(int, int, int, int)> dfs = [&](int r, int c, int pr, int pc) {
            visited[r][c] = true;

            int dr[] = {0, 0, 1, -1};
            int dc[] = {1, -1, 0, 0};

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] == grid[r][c]) {
                    if (nr == pr && nc == pc) continue;
                    if (visited[nr][nc]) return true;
                    if (dfs(nr, nc, r, c)) return true;
                }
            }
            return false;
        };

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (!visited[i][j]) {
                    if (dfs(i, j, -1, -1)) return true;
                }
            }
        }

        return false;
    }
};