#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int ballGame(int n, int m, vector<vector<int>>& grid) {
        vector<vector<bool>> visited(n, vector<bool>(m, false));
        queue<pair<int, int>> q;

        for (int i = 0; i < n; ++i) {
            if (grid[i][0] == 1) {
                q.push({i, 0});
                visited[i][0] = true;
            }
            if (grid[i][m-1] == 1) {
                q.push({i, m-1});
                visited[i][m-1] = true;
            }
        }

        for (int j = 0; j < m; ++j) {
            if (grid[0][j] == 1) {
                q.push({0, j});
                visited[0][j] = true;
            }
            if (grid[n-1][j] == 1) {
                q.push({n-1, j});
                visited[n-1][j] = true;
            }
        }

        int count = 0;
        while (!q.empty()) {
            auto [i, j] = q.front();
            q.pop();
            ++count;

            int dx[] = {-1, 1, 0, 0};
            int dy[] = {0, 0, -1, 1};

            for (int k = 0; k < 4; ++k) {
                int ni = i + dx[k];
                int nj = j + dy[k];

                if (ni >= 0 && ni < n && nj >= 0 && nj < m && !visited[ni][nj] && grid[ni][nj] == 1) {
                    visited[ni][nj] = true;
                    q.push({ni, nj});
                }
            }
        }

        return count;
    }
};