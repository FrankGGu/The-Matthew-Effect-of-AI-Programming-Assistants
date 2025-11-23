#include <iostream>
#include <vector>
#include <queue>
#include <cmath>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> kNearestObstacles(int n, vector<vector<int>>& queries, vector<vector<int>>& obstacles) {
        vector<int> result;
        unordered_map<int, vector<pair<int, int>>> grid;

        for (const auto& obs : obstacles) {
            int x = obs[0];
            int y = obs[1];
            int key = x * 100000 + y;
            grid[key].push_back({x, y});
        }

        for (const auto& q : queries) {
            int x = q[0];
            int y = q[1];
            int k = q[2];
            priority_queue<pair<int, pair<int, int>>> pq;

            for (const auto& obs : obstacles) {
                int ox = obs[0];
                int oy = obs[1];
                int dist = abs(x - ox) + abs(y - oy);
                pq.push({-dist, {ox, oy}});
                if (pq.size() > k) {
                    pq.pop();
                }
            }

            vector<pair<int, int>> nearest;
            while (!pq.empty()) {
                nearest.push_back(pq.top().second);
                pq.pop();
            }

            sort(nearest.begin(), nearest.end(), [&](const pair<int, int>& a, const pair<int, int>& b) {
                int distA = abs(x - a.first) + abs(y - a.second);
                int distB = abs(x - b.first) + abs(y - b.second);
                return distA < distB;
            });

            result.push_back(nearest[k - 1].first * 100000 + nearest[k - 1].second);
        }

        return result;
    }
};