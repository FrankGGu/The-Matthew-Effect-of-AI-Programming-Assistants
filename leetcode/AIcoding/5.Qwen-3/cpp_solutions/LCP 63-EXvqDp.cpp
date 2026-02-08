#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int ballGame(int n, int m, vector<string>& grid) {
        vector<vector<bool>> visited(n, vector<bool>(m, false));
        queue<pair<int, int>> q;

        for (int i = 0; i < n; ++i) {
            if (grid[i][0] == 'B') {
                q.push({i, 0});
                visited[i][0] = true;
            }
            if (grid[i][m - 1] == 'B') {
                q.push({i, m - 1});
                visited[i][m - 1] = true;
            }
        }

        for (int j = 0; j < m; ++j) {
            if (grid[0][j] == 'B') {
                q.push({0, j});
                visited[0][j] = true;
            }
            if (grid[n - 1][j] == 'B') {
                q.push({n - 1, j});
                visited[n - 1][j] = true;
            }
        }

        int count = 0;
        while (!q.empty()) {
            auto [i, j] = q.front();
            q.pop();
            ++count;

            for (int di = -1; di <= 1; ++di) {
                for (int dj = -1; dj <= 1; ++dj) {
                    if (di == 0 || dj == 0) continue;
                    int ni = i + di;
                    int nj = j + dj;
                    if (ni >= 0 && ni < n && nj >= 0 && nj < m && !visited[ni][nj] && grid[ni][nj] == 'B') {
                        visited[ni][nj] = true;
                        q.push({ni, nj});
                    }
                }
            }
        }

        return count;
    }
};