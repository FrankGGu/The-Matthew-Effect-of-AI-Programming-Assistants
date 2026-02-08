#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool containsCycle(vector<vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        vector<vector<int>> directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (!visited[i][j]) {
                    queue<pair<int, int>> q;
                    q.push({i, j});
                    visited[i][j] = true;
                    vector<vector<int>> parent(m, vector<int>(n, -1));
                    while (!q.empty()) {
                        auto [x, y] = q.front();
                        q.pop();
                        for (const auto& dir : directions) {
                            int nx = x + dir[0];
                            int ny = y + dir[1];
                            if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && grid[nx][ny] == grid[x][y]) {
                                visited[nx][ny] = true;
                                parent[nx][ny] = grid[x][y];
                                q.push({nx, ny});
                            } else if (visited[nx][ny] && parent[x][y] != -1 && grid[nx][ny] == grid[x][y] && parent[nx][ny] == grid[x][y]) {
                                return true;
                            }
                        }
                    }
                }
            }
        }
        return false;
    }
};