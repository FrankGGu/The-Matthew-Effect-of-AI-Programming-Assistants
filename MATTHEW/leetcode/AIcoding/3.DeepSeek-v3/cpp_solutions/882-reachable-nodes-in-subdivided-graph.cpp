class Solution {
public:
    int reachableNodes(vector<vector<int>>& edges, int maxMoves, int n) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph[u].emplace_back(v, w + 1);
            graph[v].emplace_back(u, w + 1);
        }

        vector<int> dist(n, INT_MAX);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.emplace(0, 0);
        dist[0] = 0;

        while (!pq.empty()) {
            auto [d, u] = pq.top();
            pq.pop();
            if (d > dist[u]) continue;
            for (auto& [v, w] : graph[u]) {
                if (dist[v] > d + w) {
                    dist[v] = d + w;
                    pq.emplace(dist[v], v);
                }
            }
        }

        int res = 0;
        for (int i = 0; i < n; ++i) {
            if (dist[i] <= maxMoves) ++res;
        }

        for (auto& edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            int a = max(0, maxMoves - dist[u]);
            int b = max(0, maxMoves - dist[v]);
            res += min(a + b, w);
        }

        return res;
    }
};