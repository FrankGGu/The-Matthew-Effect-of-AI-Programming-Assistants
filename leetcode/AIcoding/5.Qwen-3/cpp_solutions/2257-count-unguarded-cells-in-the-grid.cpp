#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countUnguarded(int m, int n, vector<vector<int>>& guards, vector<vector<int>>& walls) {
        vector<vector<int>> grid(m, vector<int>(n, 0));
        vector<vector<bool>> visited(m, vector<bool>(n, false));

        for (const auto& guard : guards) {
            int x = guard[0], y = guard[1];
            grid[x][y] = 2;
        }

        for (const auto& wall : walls) {
            int x = wall[0], y = wall[1];
            grid[x][y] = 3;
        }

        vector<vector<int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        for (const auto& guard : guards) {
            int x = guard[0], y = guard[1];
            for (const auto& dir : directions) {
                int dx = dir[0], dy = dir[1];
                int nx = x + dx, ny = y + dy;
                while (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] != 2 && grid[nx][ny] != 3) {
                    if (!visited[nx][ny]) {
                        visited[nx][ny] = true;
                    }
                    nx += dx;
                    ny += dy;
                }
            }
        }

        int count = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (!visited[i][j] && grid[i][j] != 2 && grid[i][j] != 3) {
                    ++count;
                }
            }
        }

        return count;
    }
};