#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfInfectionSequences(int n, vector<vector<int>>& graph) {
        vector<vector<int>> adj(n);
        for (const auto& edge : graph) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        vector<int> order;
        int result = 0;

        function<void(int)> dfs = [&](int node) {
            visited[node] = true;
            order.push_back(node);

            if (order.size() == n) {
                ++result;
                visited[node] = false;
                order.pop_back();
                return;
            }

            for (int neighbor : adj[node]) {
                if (!visited[neighbor]) {
                    dfs(neighbor);
                }
            }

            visited[node] = false;
            order.pop_back();
        };

        for (int i = 0; i < n; ++i) {
            dfs(i);
        }

        return result;
    }
};