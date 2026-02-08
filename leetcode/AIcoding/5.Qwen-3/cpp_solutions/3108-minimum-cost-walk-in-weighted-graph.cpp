#include <iostream>
#include <vector>
#include <queue>
#include <cmath>

using namespace std;

class Solution {
public:
    int minCostWalk(int n, vector<vector<int>>& edges, int start, int end, int k) {
        vector<vector<pair<int, int>>> graph(n);
        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph[u].push_back({v, w});
            graph[v].push_back({u, w});
        }

        vector<vector<int>> dist(n, vector<int>(k + 1, INT_MAX));
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<>> pq;
        dist[start][0] = 0;
        pq.push({0, {start, 0}});

        while (!pq.empty()) {
            int cost = pq.top().first;
            int node = pq.top().second.first;
            int steps = pq.top().second.second;
            pq.pop();

            if (node == end) return cost;

            if (steps >= k) continue;

            for (const auto& neighbor : graph[node]) {
                int nextNode = neighbor.first;
                int weight = neighbor.second;
                if (dist[nextNode][steps + 1] > cost + weight) {
                    dist[nextNode][steps + 1] = cost + weight;
                    pq.push({dist[nextNode][steps + 1], {nextNode, steps + 1}});
                }
            }
        }

        return -1;
    }
};