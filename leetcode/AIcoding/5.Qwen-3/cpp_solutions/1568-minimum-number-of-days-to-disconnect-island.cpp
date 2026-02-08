#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minDays(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        auto countIslands = [&](vector<vector<int>>& g) {
            vector<vector<bool>> visited(m, vector<bool>(n, false));
            int count = 0;
            for (int i = 0; i < m; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (g[i][j] == 1 && !visited[i][j]) {
                        ++count;
                        queue<pair<int, int>> q;
                        q.push({i, j});
                        visited[i][j] = true;
                        while (!q.empty()) {
                            auto [x, y] = q.front();
                            q.pop();
                            for (int dx = -1; dx <= 1; ++dx) {
                                for (int dy = -1; dy <= 1; ++dy) {
                                    if (abs(dx) + abs(dy) == 1 && x + dx >= 0 && x + dx < m && y + dy >= 0 && y + dy < n && !visited[x + dx][y + dy] && g[x + dx][y + dy] == 1) {
                                        visited[x + dx][y + dy] = true;
                                        q.push({x + dx, y + dy});
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return count;
        };

        int initial = countIslands(grid);
        if (initial != 1) return 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    grid[i][j] = 0;
                    if (countIslands(grid) != 1) {
                        return 1;
                    }
                    grid[i][j] = 1;
                }
            }
        }

        return 2;
    }
};