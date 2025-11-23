#include <vector>
#include <queue>
#include <tuple>

using namespace std;

class Solution {
public:
    int minimumCost(int startX, int startY, int targetX, int targetY, vector<vector<int>>& specialRoads) {
        auto dist = [&](int x1, int y1, int x2, int y2) {
            return abs(x1 - x2) + abs(y1 - y2);
        };

        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
        pq.push({0, {startX, startY}});

        unordered_map<long long, int> d;
        d[((long long)startX << 32) | startY] = 0;

        while (!pq.empty()) {
            int cost = pq.top().first;
            int x = pq.top().second.first;
            int y = pq.top().second.second;
            pq.pop();

            long long curr = ((long long)x << 32) | y;
            if (d.count(curr) && d[curr] < cost) continue;

            if (x == targetX && y == targetY) return cost;

            if (!d.count(curr) || d[curr] > cost) {
                d[curr] = cost;
            }

            if (d.count(curr) && d[curr] < cost) continue;

            if (d.count(curr) && d[curr] < cost) continue;

            int straightCost = dist(x, y, targetX, targetY);
            if (!d.count(((long long)targetX << 32) | targetY) || d[((long long)targetX << 32) | targetY] > cost + straightCost) {
                d[((long long)targetX << 32) | targetY] = cost + straightCost;
                pq.push({cost + straightCost, {targetX, targetY}});
            }

            for (auto& road : specialRoads) {
                int x1 = road[0], y1 = road[1], x2 = road[2], y2 = road[3], c = road[4];
                int newCost = cost + c;
                newCost += dist(x, y, x1, y1);

                if (!d.count(((long long)x2 << 32) | y2) || d[((long long)x2 << 32) | y2] > newCost) {
                    d[((long long)x2 << 32) | y2] = newCost;
                    pq.push({newCost, {x2, y2}});
                }
            }
        }

        return d[((long long)targetX << 32) | targetY];
    }
};