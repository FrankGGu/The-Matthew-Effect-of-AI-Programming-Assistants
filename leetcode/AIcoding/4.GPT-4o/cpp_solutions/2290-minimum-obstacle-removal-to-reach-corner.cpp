#include <vector>
#include <queue>
#include <utility>

using namespace std;

class Solution {
public:
    int minimumObstacles(vector<vector<int>>& grid) {
        int n = grid.size(), m = grid[0].size();
        vector<vector<int>> dist(n, vector<int>(m, INT_MAX));
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;

        pq.push({0, {0, 0}});
        dist[0][0] = 0;

        vector<int> dir = {0, 1, 0, -1, 0}; // Directions for right, down, left, up

        while (!pq.empty()) {
            auto [obstacles, pos] = pq.top();
            pq.pop();
            int x = pos.first, y = pos.second;

            if (x == n - 1 && y == m - 1) return obstacles;

            for (int i = 0; i < 4; i++) {
                int nx = x + dir[i], ny = y + dir[i + 1];
                if (nx >= 0 && nx < n && ny >= 0 && ny < m) {
                    int new_obstacles = obstacles + grid[nx][ny];
                    if (new_obstacles < dist[nx][ny]) {
                        dist[nx][ny] = new_obstacles;
                        pq.push({new_obstacles, {nx, ny}});
                    }
                }
            }
        }
        return -1; // unreachable condition, should not happen per problem statement
    }
};