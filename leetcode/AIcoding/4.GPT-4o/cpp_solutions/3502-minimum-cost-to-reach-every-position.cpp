#include <vector>
#include <queue>
#include <algorithm>
using namespace std;

class Solution {
public:
    int minCost(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> dist(m, vector<int>(n, INT_MAX));
        dist[0][0] = 0;
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
        pq.push({0, {0, 0}});
        vector<pair<int, int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!pq.empty()) {
            auto [cost, pos] = pq.top();
            pq.pop();
            int x = pos.first, y = pos.second;
            if (cost > dist[x][y]) continue;

            for (int i = 0; i < 4; ++i) {
                int nx = x + directions[i].first, ny = y + directions[i].second;
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int newCost = cost + (grid[x][y] - 1 != i);
                    if (newCost < dist[nx][ny]) {
                        dist[nx][ny] = newCost;
                        pq.push({newCost, {nx, ny}});
                    }
                }
            }
        }

        return dist[m - 1][n - 1];
    }
};