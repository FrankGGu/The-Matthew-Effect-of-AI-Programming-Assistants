#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> minEdgeEquilibriumQueries(int n, vector<vector<int>>& edges, vector<vector<int>>& queries) {
        vector<vector<pair<int, int>>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].emplace_back(edge[1], edge[2]);
            adj[edge[1]].emplace_back(edge[0], edge[2]);
        }

        vector<int> result;
        for (const auto& q : queries) {
            int u = q[0], v = q[1];
            vector<int> subtreeSum(n, 0);
            vector<bool> visited(n, false);

            function<void(int, int)> dfs = [&](int node, int parent) {
                visited[node] = true;
                subtreeSum[node] = 0;
                for (const auto& [neighbor, weight] : adj[node]) {
                    if (neighbor != parent) {
                        dfs(neighbor, node);
                        subtreeSum[node] += subtreeSum[neighbor];
                    }
                }
                subtreeSum[node] += 1;
            };

            dfs(u, -1);
            int total = subtreeSum[u];
            int sumU = subtreeSum[u];
            int sumV = total - sumU;

            int minWeight = INT_MAX;
            for (const auto& [neighbor, weight] : adj[u]) {
                if (!visited[neighbor]) {
                    minWeight = min(minWeight, weight);
                }
            }

            for (const auto& [neighbor, weight] : adj[v]) {
                if (!visited[neighbor]) {
                    minWeight = min(minWeight, weight);
                }
            }

            result.push_back(minWeight);
        }
        return result;
    }
};