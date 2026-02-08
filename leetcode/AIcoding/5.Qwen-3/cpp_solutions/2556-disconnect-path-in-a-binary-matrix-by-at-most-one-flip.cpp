#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool isPossible(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<bool>> visited(m, vector<bool>(n, false));
        queue<pair<int, int>> q;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    q.push({i, j});
                    visited[i][j] = true;
                    break;
                }
            }
            if (!q.empty()) break;
        }

        int dir[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();

            for (int i = 0; i < 4; ++i) {
                int nx = x + dir[i][0];
                int ny = y + dir[i][1];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && grid[nx][ny] == 1) {
                    visited[nx][ny] = true;
                    q.push({nx, ny});
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1 && !visited[i][j]) {
                    return false;
                }
            }
        }

        return true;
    }

    int minFlips(vector<vector<int>>& grid) {
        if (isPossible(grid)) return 0;

        int m = grid.size();
        int n = grid[0].size();

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    grid[i][j] = 0;
                    if (isPossible(grid)) {
                        grid[i][j] = 1;
                        return 1;
                    }
                    grid[i][j] = 1;
                }
            }
        }

        return 2;
    }
};