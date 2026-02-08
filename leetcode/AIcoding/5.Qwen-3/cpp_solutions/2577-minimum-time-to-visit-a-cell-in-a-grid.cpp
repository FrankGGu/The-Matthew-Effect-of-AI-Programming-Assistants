#include <iostream>
#include <vector>
#include <queue>
#include <utility>
#include <climits>

using namespace std;

class Solution {
public:
    int minimumTime(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        if (grid[0][1] > 1 && grid[1][0] > 1) {
            return -1;
        }

        vector<vector<int>> dist(m, vector<int>(n, INT_MAX));
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<>> pq;
        pq.push({0, {0, 0}});
        dist[0][0] = 0;

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!pq.empty()) {
            auto [time, pos] = pq.top();
            pq.pop();
            int x = pos.first;
            int y = pos.second;

            if (x == m - 1 && y == n - 1) {
                return time;
            }

            if (time > dist[x][y]) {
                continue;
            }

            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int new_time = time + 1;
                    if (grid[nx][ny] > new_time) {
                        new_time = grid[nx][ny] + (grid[nx][ny] - new_time) % 2;
                    }
                    if (new_time < dist[nx][ny]) {
                        dist[nx][ny] = new_time;
                        pq.push({new_time, {nx, ny}});
                    }
                }
            }
        }

        return -1;
    }
};