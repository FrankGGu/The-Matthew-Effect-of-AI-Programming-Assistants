#include <iostream>
#include <vector>
#include <stack>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> criticalConnections(int n, vector<vector<int>>& connections) {
        vector<vector<int>> graph(n);
        for (const auto& conn : connections) {
            graph[conn[0]].push_back(conn[1]);
            graph[conn[1]].push_back(conn[0]);
        }

        vector<int> disc(n, -1);
        vector<int> low(n, -1);
        vector<bool> visited(n, false);
        vector<vector<int>> result;
        int time = 0;

        function<void(int, int)> dfs = [&](int u, int parent) {
            visited[u] = true;
            disc[u] = low[u] = time++;
            for (int v : graph[u]) {
                if (v == parent) continue;
                if (!visited[v]) {
                    dfs(v, u);
                    low[u] = min(low[u], low[v]);
                    if (low[v] > disc[u]) {
                        result.push_back({u, v});
                    }
                } else {
                    low[u] = min(low[u], disc[v]);
                }
            }
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                dfs(i, -1);
            }
        }

        return result;
    }
};