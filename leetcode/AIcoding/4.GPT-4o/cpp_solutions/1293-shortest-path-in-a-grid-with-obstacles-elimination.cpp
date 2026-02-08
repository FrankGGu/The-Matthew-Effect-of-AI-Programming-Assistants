#include <vector>
#include <queue>
#include <tuple>
#include <algorithm>

using namespace std;

class Solution {
public:
    int shortestPath(vector<vector<int>>& grid, int k) {
        int m = grid.size(), n = grid[0].size();
        if (m == 0 || n == 0) return -1;
        vector<vector<int>> visited(m, vector<int>(n, -1));
        queue<tuple<int, int, int, int>> q; // (row, col, obstacles, distance)
        q.push({0, 0, 0, 0});
        visited[0][0] = 0;

        vector<int> dirs = {0, 1, 0, -1, 0}; // right, down, left, up

        while (!q.empty()) {
            auto [x, y, obstacles, dist] = q.front();
            q.pop();
            if (x == m - 1 && y == n - 1) return dist;

            for (int i = 0; i < 4; i++) {
                int nx = x + dirs[i];
                int ny = y + dirs[i + 1];
                if (nx < 0 || ny < 0 || nx >= m || ny >= n) continue;

                int newObstacles = obstacles + grid[nx][ny];
                if (newObstacles <= k && (visited[nx][ny] == -1 || newObstacles < visited[nx][ny])) {
                    visited[nx][ny] = newObstacles;
                    q.push({nx, ny, newObstacles, dist + 1});
                }
            }
        }
        return -1;
    }
};