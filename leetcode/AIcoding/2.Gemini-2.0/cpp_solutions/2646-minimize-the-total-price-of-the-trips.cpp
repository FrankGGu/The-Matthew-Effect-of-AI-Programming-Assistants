#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumTotalPrice(int n, vector<vector<int>>& edges, vector<int>& price, vector<vector<int>>& trips) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<int> count(n, 0);
        for (auto& trip : trips) {
            vector<int> path;
            vector<int> parent(n, -1);
            vector<bool> visited(n, false);
            function<bool(int, int)> dfs = [&](int u, int target) {
                visited[u] = true;
                path.push_back(u);
                if (u == target) {
                    return true;
                }
                for (int v : adj[u]) {
                    if (!visited[v]) {
                        parent[v] = u;
                        if (dfs(v, target)) {
                            return true;
                        }
                    }
                }
                path.pop_back();
                return false;
            };

            dfs(trip[0], trip[1]);

            int cur = trip[1];
            while (cur != -1) {
                count[cur]++;
                cur = parent[cur];
            }
        }

        vector<vector<int>> dp(n, vector<int>(2, 0));
        vector<bool> visited(n, false);

        function<void(int)> solve = [&](int u) {
            visited[u] = true;
            dp[u][0] = price[u] * count[u];
            dp[u][1] = dp[u][0] / 2;

            for (int v : adj[u]) {
                if (!visited[v]) {
                    solve(v);
                    dp[u][0] += min(dp[v][0], dp[v][1]);
                    dp[u][1] += dp[v][0];
                }
            }
        };

        solve(0);
        return min(dp[0][0], dp[0][1]);
    }
};