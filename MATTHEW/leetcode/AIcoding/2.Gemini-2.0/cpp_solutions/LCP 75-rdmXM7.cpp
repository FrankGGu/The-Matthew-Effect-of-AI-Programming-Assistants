#include <vector>
#include <queue>

using namespace std;

int minCost(int start, int target, vector<vector<int>>& specialRoads) {
    priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
    pq.push({0, {start, start}});

    vector<int> dist(1001, INT_MAX);
    dist[start] = 0;

    while (!pq.empty()) {
        int cost = pq.top().first;
        int u = pq.top().second.first;
        int last = pq.top().second.second;
        pq.pop();

        if (cost > dist[u]) continue;

        if (u == target) return cost;

        int directCost = abs(target - u);
        if (dist[target] > cost + directCost) {
            dist[target] = cost + directCost;
            pq.push({dist[target], {target, u}});
        }

        for (auto& road : specialRoads) {
            int x1 = road[0];
            int y1 = road[1];
            int x2 = road[2];
            int y2 = road[3];
            int c = road[4];

            int travelCost = abs(x1 - u) + abs(y1 - last);
            if (travelCost >= 0){
                if (dist[x2] > cost + travelCost + c) {
                    dist[x2] = cost + travelCost + c;
                    pq.push({dist[x2], {x2, y2}});
                }
            }
        }
    }

    return dist[target];
}