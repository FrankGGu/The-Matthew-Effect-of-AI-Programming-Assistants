class Solution {
public:
    int maximalPathQuality(vector<int>& values, vector<vector<int>>& edges, int maxTime) {
        int n = values.size();
        vector<vector<pair<int, int>>> adj(n);
        for (auto& e : edges) {
            int u = e[0], v = e[1], t = e[2];
            adj[u].emplace_back(v, t);
            adj[v].emplace_back(u, t);
        }

        vector<int> visited(n, 0);
        int res = values[0];
        visited[0]++;

        function<void(int, int, int)> dfs = [&](int u, int time, int quality) {
            if (u == 0) {
                res = max(res, quality);
            }
            for (auto& [v, t] : adj[u]) {
                if (time + t <= maxTime) {
                    if (visited[v] == 0) {
                        quality += values[v];
                    }
                    visited[v]++;
                    dfs(v, time + t, quality);
                    visited[v]--;
                    if (visited[v] == 0) {
                        quality -= values[v];
                    }
                }
            }
        };

        dfs(0, 0, values[0]);
        return res;
    }
};