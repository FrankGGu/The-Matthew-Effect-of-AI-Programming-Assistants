#include <vector>

using namespace std;

class Solution {
public:
    int numEnclaves(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<bool>> visited(m, vector<bool>(n, false));

        function<void(int, int)> dfs = [&](int i, int j) {
            if (i < 0 || i >= m || j < 0 || j >= n || grid[i][j] == 0 || visited[i][j]) {
                return;
            }

            visited[i][j] = true;
            dfs(i + 1, j);
            dfs(i - 1, j);
            dfs(i, j + 1);
            dfs(i, j - 1);
        };

        for (int i = 0; i < m; ++i) {
            if (grid[i][0] == 1) {
                dfs(i, 0);
            }
            if (grid[i][n - 1] == 1) {
                dfs(i, n - 1);
            }
        }

        for (int j = 0; j < n; ++j) {
            if (grid[0][j] == 1) {
                dfs(0, j);
            }
            if (grid[m - 1][j] == 1) {
                dfs(m - 1, j);
            }
        }

        int count = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1 && !visited[i][j]) {
                    count++;
                }
            }
        }

        return count;
    }
};