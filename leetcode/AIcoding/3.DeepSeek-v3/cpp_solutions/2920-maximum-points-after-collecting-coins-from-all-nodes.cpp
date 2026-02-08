class Solution {
public:
    int maximumPoints(vector<vector<int>>& edges, vector<int>& coins, int k) {
        int n = coins.size();
        vector<vector<int>> adj(n);
        for (auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        vector<vector<int>> dp(n, vector<int>(15, -1));

        function<int(int, int, int)> dfs = [&](int u, int p, int t) {
            if (t >= 14) return 0;
            if (dp[u][t] != -1) return dp[u][t];

            int option1 = (coins[u] >> t) - k;
            int option2 = coins[u] >> (t + 1);

            for (int v : adj[u]) {
                if (v != p) {
                    option1 += dfs(v, u, t);
                    option2 += dfs(v, u, t + 1);
                }
            }

            return dp[u][t] = max(option1, option2);
        };

        return dfs(0, -1, 0);
    }
};