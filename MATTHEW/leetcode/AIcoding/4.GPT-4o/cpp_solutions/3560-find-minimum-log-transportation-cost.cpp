#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int minimumCost(vector<vector<int>>& paths) {
        int n = 0;
        for (const auto& path : paths) {
            n = max(n, path[0]);
            n = max(n, path[1]);
        }
        n += 1;

        vector<vector<pair<int, int>>> graph(n);
        for (const auto& path : paths) {
            graph[path[0]].emplace_back(path[1], path[2]);
            graph[path[1]].emplace_back(path[0], path[2]);
        }

        vector<int> dist(n, INT_MAX);
        dist[1] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.push({0, 1});

        while (!pq.empty()) {
            auto [cost, node] = pq.top();
            pq.pop();

            if (cost > dist[node]) continue;

            for (const auto& [neighbor, weight] : graph[node]) {
                if (dist[node] + weight < dist[neighbor]) {
                    dist[neighbor] = dist[node] + weight;
                    pq.push({dist[neighbor], neighbor});
                }
            }
        }

        int result = *max_element(dist.begin() + 1, dist.end());
        return result == INT_MAX ? -1 : result;
    }
};