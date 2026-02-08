class Solution {
public:
    vector<int> countPairsOfConnectableServers(vector<vector<int>>& edges, int signalSpeed) {
        int n = edges.size() + 1;
        vector<vector<pair<int, int>>> adj(n);
        for (auto& e : edges) {
            int u = e[0], v = e[1], w = e[2];
            adj[u].emplace_back(v, w);
            adj[v].emplace_back(u, w);
        }

        vector<int> res(n, 0);
        for (int c = 0; c < n; ++c) {
            vector<int> counts;
            for (auto& [v, w] : adj[c]) {
                int cnt = 0;
                dfs(v, c, w, adj, signalSpeed, cnt);
                counts.push_back(cnt);
            }
            int total = 0;
            for (int i = 0; i < counts.size(); ++i) {
                res[c] += total * counts[i];
                total += counts[i];
            }
        }
        return res;
    }

    void dfs(int u, int parent, int sum, vector<vector<pair<int, int>>>& adj, int signalSpeed, int& cnt) {
        if (sum % signalSpeed == 0) {
            cnt++;
        }
        for (auto& [v, w] : adj[u]) {
            if (v != parent) {
                dfs(v, u, sum + w, adj, signalSpeed, cnt);
            }
        }
    }
};