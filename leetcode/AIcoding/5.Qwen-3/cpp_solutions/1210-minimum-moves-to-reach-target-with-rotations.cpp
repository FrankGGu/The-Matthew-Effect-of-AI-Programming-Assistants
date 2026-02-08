#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minimumMoves(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<vector<int>>> visited(n, vector<vector<int>>(n, vector<int>(2, -1)));
        queue<pair<int, int>> q;
        q.push({0, 0});
        visited[0][0][0] = 0;
        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();
            int steps = visited[x][y][0];
            if (x == n - 1 && y == n - 1) return steps;
            for (int d = 0; d < 4; ++d) {
                int nx = x + (d == 0 ? -1 : d == 1 ? 1 : 0);
                int ny = y + (d == 2 ? -1 : d == 3 ? 1 : 0);
                if (nx >= 0 && ny >= 0 && nx < n && ny < n && grid[nx][ny] == 0 && visited[nx][ny][0] == -1) {
                    visited[nx][ny][0] = steps + 1;
                    q.push({nx, ny});
                }
            }
            if (visited[x][y][0] != -1) {
                if (x + 1 < n && grid[x][y] == 0 && grid[x + 1][y] == 0 && visited[x][y][1] == -1) {
                    visited[x][y][1] = steps + 1;
                    q.push({x, y});
                }
                if (y + 1 < n && grid[x][y] == 0 && grid[x][y + 1] == 0 && visited[x][y][1] == -1) {
                    visited[x][y][1] = steps + 1;
                    q.push({x, y});
                }
            }
        }
        return -1;
    }
};