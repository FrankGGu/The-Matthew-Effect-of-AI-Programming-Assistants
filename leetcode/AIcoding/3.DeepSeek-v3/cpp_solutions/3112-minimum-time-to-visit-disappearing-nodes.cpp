class Solution {
public:
    vector<int> minimumTime(int n, vector<vector<int>>& edges, vector<int>& disappear) {
        vector<vector<pair<int, int>>> adj(n);
        for (const auto& e : edges) {
            int u = e[0], v = e[1], w = e[2];
            adj[u].emplace_back(v, w);
            adj[v].emplace_back(u, w);
        }

        vector<int> dist(n, INT_MAX);
        dist[0] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.emplace(0, 0);

        while (!pq.empty()) {
            auto [d, u] = pq.top();
            pq.pop();
            if (d > dist[u]) continue;
            for (const auto& [v, w] : adj[u]) {
                if (d + w < dist[v] && d + w < disappear[v]) {
                    dist[v] = d + w;
                    pq.emplace(dist[v], v);
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            if (dist[i] == INT_MAX) {
                dist[i] = -1;
            }
        }
        return dist;
    }
};