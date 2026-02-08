#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int minCostToReachDestination(int n, vector<vector<int>>& roads, int dp) {
        vector<vector<pair<int, int>>> graph(n);
        for (const auto& road : roads) {
            int u = road[0], v = road[1], cost = road[2], time = road[3];
            graph[u].push_back({v, cost});
            graph[v].push_back({u, cost});
        }

        vector<int> dist(n, INT_MAX);
        dist[0] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        pq.push({0, 0});

        while (!pq.empty()) {
            int currentCost = pq.top().first;
            int node = pq.top().second;
            pq.pop();

            if (node == n - 1) break;

            if (currentCost > dist[node]) continue;

            for (const auto& neighbor : graph[node]) {
                int nextNode = neighbor.first;
                int newCost = currentCost + neighbor.second;
                if (newCost < dist[nextNode]) {
                    dist[nextNode] = newCost;
                    pq.push({newCost, nextNode});
                }
            }
        }

        return dist[n - 1];
    }
};