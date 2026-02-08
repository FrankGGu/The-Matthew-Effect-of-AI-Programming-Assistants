#include <vector>
#include <queue>
#include <tuple>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumCost(int n, vector<vector<int>>& connections) {
        unordered_map<int, vector<pair<int, int>>> graph;
        for (const auto& conn : connections) {
            graph[conn[0]].emplace_back(conn[1], conn[2]);
            graph[conn[1]].emplace_back(conn[0], conn[2]);
        }

        priority_queue<tuple<int, int>, vector<tuple<int, int>>, greater<tuple<int, int>>> pq;
        vector<int> minCost(n + 1, INT_MAX);
        minCost[1] = 0;
        pq.emplace(0, 1);

        while (!pq.empty()) {
            auto [cost, node] = pq.top(); pq.pop();
            if (cost > minCost[node]) continue;
            for (const auto& [neighbor, weight] : graph[node]) {
                if (cost + weight < minCost[neighbor]) {
                    minCost[neighbor] = cost + weight;
                    pq.emplace(minCost[neighbor], neighbor);
                }
            }
        }

        int result = *max_element(minCost.begin() + 1, minCost.end());
        return result == INT_MAX ? -1 : result;
    }
};