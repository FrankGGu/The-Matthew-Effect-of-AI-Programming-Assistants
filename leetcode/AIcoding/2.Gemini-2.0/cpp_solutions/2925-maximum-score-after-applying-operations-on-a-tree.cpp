#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumScoreAfterOperations(vector<vector<int>>& edges, vector<int>& values) {
        int n = values.size();
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<vector<long long>> dp(n, vector<long long>(2, 0));

        function<void(int, int)> dfs = [&](int u, int parent) {
            dp[u][0] = 0;
            dp[u][1] = values[u];

            for (int v : adj[u]) {
                if (v != parent) {
                    dfs(v, u);
                    dp[u][0] += max(dp[v][0], dp[v][1]);
                    dp[u][1] += dp[v][0];
                }
            }
        };

        dfs(0, -1);

        return max(dp[0][0], dp[0][1]);
    }
};