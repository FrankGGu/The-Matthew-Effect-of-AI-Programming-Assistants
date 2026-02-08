#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> criticalConnections(int n, vector<vector<int>>& connections) {
        vector<vector<int>> adj(n);
        for (const auto& connection : connections) {
            adj[connection[0]].push_back(connection[1]);
            adj[connection[1]].push_back(connection[0]);
        }

        vector<int> disc(n, -1);
        vector<int> low(n, -1);
        vector<vector<int>> result;
        int time = 0;

        function<void(int, int)> dfs = [&](int u, int parent) {
            disc[u] = low[u] = time++;

            for (int v : adj[u]) {
                if (v == parent) continue;

                if (disc[v] == -1) {
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
            if (disc[i] == -1) {
                dfs(i, -1);
            }
        }

        return result;
    }
};