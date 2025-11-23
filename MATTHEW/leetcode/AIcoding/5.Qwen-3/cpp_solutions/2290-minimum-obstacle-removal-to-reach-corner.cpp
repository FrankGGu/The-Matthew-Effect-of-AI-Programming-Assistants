#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minimumObstacleRemovalToReachCorner(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dist(m, vector<int>(n, -1));
        queue<pair<int, int>> q;
        q.push({0, 0});
        dist[0][0] = 0;

        int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();
            for (auto& [dx, dy] : directions) {
                int nx = x + dx;
                int ny = y + dy;
                if (nx >= 0 && ny >= 0 && nx < m && ny < n && dist[nx][ny] == -1) {
                    dist[nx][ny] = dist[x][y] + grid[nx][ny];
                    q.push({nx, ny});
                }
            }
        }

        return dist[m-1][n-1];
    }
};