class Solution {
public:
    long long maximumScoreAfterOperations(vector<vector<int>>& edges, vector<int>& values) {
        int n = values.size();
        vector<vector<int>> adj(n);
        for (auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        vector<pair<long long, long long>> dp(n);
        function<void(int, int)> dfs = [&](int u, int parent) {
            long long sum = 0, min_sum = 0;
            bool is_leaf = true;
            for (int v : adj[u]) {
                if (v != parent) {
                    is_leaf = false;
                    dfs(v, u);
                    sum += dp[v].first;
                    min_sum += dp[v].second;
                }
            }
            if (is_leaf) {
                dp[u] = {values[u], 0};
            } else {
                dp[u] = {sum + values[u], min(values[u] + min_sum, sum)};
            }
        };

        dfs(0, -1);
        return dp[0].second;
    }
};