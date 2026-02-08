#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<long long> placedCoins(vector<vector<int>>& edges, vector<int>& cost) {
        int n = cost.size();
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<long long> ans(n, 0);
        vector<bool> visited(n, false);

        function<void(int)> dfs = [&](int u) {
            visited[u] = true;
            vector<int> neighbors;
            for (int v : adj[u]) {
                if (!visited[v]) {
                    neighbors.push_back(v);
                    dfs(v);
                }
            }

            vector<int> vals;
            vals.push_back(cost[u]);
            for (int v : neighbors) {
                vals.push_back(cost[v]);
            }
            sort(vals.begin(), vals.end());

            if (vals.size() < 3) {
                ans[u] = 1;
            } else {
                long long prod1 = (long long)vals[0] * vals[1] * vals.back();
                long long prod2 = (long long)vals[vals.size() - 1] * vals[vals.size() - 2] * vals[vals.size() - 3];
                ans[u] = max(prod1, prod2);
            }
            if (ans[u] < 0) ans[u] = 0;
        };

        dfs(0);
        return ans;
    }
};