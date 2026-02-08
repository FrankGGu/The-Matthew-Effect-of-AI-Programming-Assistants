#include <iostream>
#include <vector>
#include <utility>

using namespace std;

class Solution {
public:
    vector<int> minEdgeReversalsToMakeAllReachable(int n, vector<vector<int>>& edges) {
        vector<vector<pair<int, int>>> graph(n);
        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1];
            graph[u].emplace_back(v, 0);
            graph[v].emplace_back(u, 1);
        }

        vector<int> result(n, 0);
        vector<bool> visited(n, false);

        function<void(int, int)> dfs = [&](int node, int parent) {
            visited[node] = true;
            for (auto& [neighbor, direction] : graph[node]) {
                if (!visited[neighbor]) {
                    result[node] += result[neighbor] + (direction == 1 ? 1 : 0);
                    dfs(neighbor, node);
                }
            }
        };

        dfs(0, -1);

        function<void(int, int)> dfs2 = [&](int node, int parent) {
            visited[node] = true;
            for (auto& [neighbor, direction] : graph[node]) {
                if (!visited[neighbor]) {
                    result[neighbor] = result[node] - (direction == 1 ? 1 : 0) + (direction == 0 ? 1 : 0);
                    dfs2(neighbor, node);
                }
            }
        };

        fill(visited.begin(), visited.end(), false);
        dfs2(0, -1);

        return result;
    }
};