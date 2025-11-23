#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int shortestBridge(vector<vector<int>>& grid) {
        int n = grid.size();
        queue<pair<int, int>> q;
        bool found = false;

        function<void(int, int)> dfs = [&](int i, int j) {
            if (i < 0 || i >= n || j < 0 || j >= n || grid[i][j] != 1) {
                return;
            }
            grid[i][j] = 2;
            q.push({i, j});
            dfs(i + 1, j);
            dfs(i - 1, j);
            dfs(i, j + 1);
            dfs(i, j - 1);
        };

        for (int i = 0; i < n && !found; ++i) {
            for (int j = 0; j < n && !found; ++j) {
                if (grid[i][j] == 1) {
                    dfs(i, j);
                    found = true;
                }
            }
        }

        int steps = 0;
        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int r = q.front().first;
                int c = q.front().second;
                q.pop();

                int dr[] = {0, 0, 1, -1};
                int dc[] = {1, -1, 0, 0};

                for (int k = 0; k < 4; ++k) {
                    int nr = r + dr[k];
                    int nc = c + dc[k];

                    if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                        if (grid[nr][nc] == 1) {
                            return steps;
                        } else if (grid[nr][nc] == 0) {
                            grid[nr][nc] = 2;
                            q.push({nr, nc});
                        }
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};