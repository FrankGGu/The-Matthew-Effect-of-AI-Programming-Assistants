class Solution {
public:
    vector<vector<int>> modifiedGraphEdges(int n, vector<vector<int>>& edges, int source, int destination, int target) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& e : edges) {
            int u = e[0], v = e[1], w = e[2];
            adj[u].emplace_back(v, w);
            adj[v].emplace_back(u, w);
        }

        auto dijkstra = [&](int src, int dst, int skip_negative) {
            priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
            vector<int> dist(n, INT_MAX);
            dist[src] = 0;
            pq.emplace(0, src);
            while (!pq.empty()) {
                auto [d, u] = pq.top();
                pq.pop();
                if (u == dst) break;
                if (d > dist[u]) continue;
                for (auto [v, w] : adj[u]) {
                    if (w == -1) {
                        if (skip_negative) continue;
                        w = 1;
                    }
                    if (dist[v] > d + w) {
                        dist[v] = d + w;
                        pq.emplace(dist[v], v);
                    }
                }
            }
            return dist[dst];
        };

        int shortest = dijkstra(source, destination, true);
        if (shortest < target) return {};
        if (shortest == target) {
            for (auto& e : edges) {
                if (e[2] == -1) e[2] = 1;
            }
            return edges;
        }

        for (auto& e : edges) {
            if (e[2] == -1) {
                e[2] = 1;
                int current = dijkstra(source, destination, true);
                if (current <= target) {
                    e[2] += target - current;
                    for (auto& e2 : edges) {
                        if (e2[2] == -1) e2[2] = 1;
                    }
                    return edges;
                }
            }
        }

        return {};
    }
};