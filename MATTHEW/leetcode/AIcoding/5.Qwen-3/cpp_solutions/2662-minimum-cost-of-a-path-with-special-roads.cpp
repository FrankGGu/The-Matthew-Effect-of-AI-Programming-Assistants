#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <utility>
#include <climits>

using namespace std;

class Solution {
public:
    int minimumCostToReachTarget(int targetX, int targetY) {
        vector<vector<int>> dirs = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<>> pq;
        pq.push({0, {0, 0}});
        unordered_map<int, unordered_map<int, int>> dist;
        dist[0][0] = 0;

        while (!pq.empty()) {
            auto [cost, pos] = pq.top();
            pq.pop();
            int x = pos.first;
            int y = pos.second;

            if (x == targetX && y == targetY) {
                return cost;
            }

            for (auto& d : dirs) {
                int nx = x + d[0];
                int ny = y + d[1];
                if (nx >= 0 && ny >= 0 && dist[nx][ny] > cost + 1) {
                    dist[nx][ny] = cost + 1;
                    pq.push({cost + 1, {nx, ny}});
                }
            }

            for (int i = 0; i <= 100; ++i) {
                for (int j = 0; j <= 100; ++j) {
                    if (i * j != 0 && (i + j) % 2 == 0) {
                        int new_cost = cost + abs(i - x) + abs(j - y);
                        if (dist[i][j] > new_cost) {
                            dist[i][j] = new_cost;
                            pq.push({new_cost, {i, j}});
                        }
                    }
                }
            }
        }

        return -1;
    }
};