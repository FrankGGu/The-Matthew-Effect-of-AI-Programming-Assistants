class Solution {
public:
    int countRestrictedPaths(int n, vector<vector<int>>& edges) {
        vector<vector<pair<int, int>>> graph(n + 1);
        for (const auto& edge : edges) {
            graph[edge[0]].emplace_back(edge[1], edge[2]);
            graph[edge[1]].emplace_back(edge[0], edge[2]);
        }

        vector<int> dist(n + 1, INT_MAX);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        dist[n] = 0;
        pq.push({0, n});

        while (!pq.empty()) {
            auto [d, node] = pq.top(); pq.pop();
            if (d > dist[node]) continue;
            for (const auto& [neighbor, weight] : graph[node]) {
                if (dist[neighbor] > d + weight) {
                    dist[neighbor] = d + weight;
                    pq.push({dist[neighbor], neighbor});
                }
            }
        }

        vector<int> dp(n + 1, 0);
        dp[n] = 1;
        const int MOD = 1e9 + 7;

        vector<vector<int>> adj(n + 1);
        for (const auto& edge : edges) {
            if (dist[edge[0]] > dist[edge[1]]) {
                adj[edge[1]].push_back(edge[0]);
            } else {
                adj[edge[0]].push_back(edge[1]);
            }
        }

        for (int i = n - 1; i >= 1; --i) {
            for (const int neighbor : adj[i]) {
                dp[i] = (dp[i] + dp[neighbor]) % MOD;
            }
        }

        return dp[1];
    }
};