class Solution {
public:
    vector<bool> findAnswer(int n, vector<vector<int>>& edges) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& e : edges) {
            int u = e[0], v = e[1], w = e[2];
            adj[u].emplace_back(v, w);
            adj[v].emplace_back(u, w);
        }

        auto dijkstra = [&](int start) {
            vector<int> dist(n, INT_MAX);
            dist[start] = 0;
            priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
            pq.emplace(0, start);
            while (!pq.empty()) {
                auto [d, u] = pq.top();
                pq.pop();
                if (d > dist[u]) continue;
                for (auto [v, w] : adj[u]) {
                    if (dist[v] > dist[u] + w) {
                        dist[v] = dist[u] + w;
                        pq.emplace(dist[v], v);
                    }
                }
            }
            return dist;
        };

        vector<int> dist0 = dijkstra(0);
        vector<int> dist1 = dijkstra(n - 1);
        int shortest = dist0[n - 1];
        if (shortest == INT_MAX) return vector<bool>(edges.size(), false);

        vector<bool> res(edges.size(), false);
        for (int i = 0; i < edges.size(); ++i) {
            int u = edges[i][0], v = edges[i][1], w = edges[i][2];
            if (dist0[u] + w + dist1[v] == shortest || dist0[v] + w + dist1[u] == shortest) {
                res[i] = true;
            }
        }
        return res;
    }
};