class Solution {
public:
    int reachableNodes(vector<vector<int>>& edges, int maxMoves, int n) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].emplace_back(edge[1], edge[2]);
            graph[edge[1]].emplace_back(edge[0], edge[2]);
        }

        vector<int> dist(n, INT_MAX);
        dist[0] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.emplace(0, 0);

        while (!pq.empty()) {
            auto [d, u] = pq.top();
            pq.pop();
            if (d > dist[u]) continue;
            for (auto& [v, w] : graph[u]) {
                if (dist[u] + w + 1 < maxMoves && dist[v] > dist[u] + w + 1) {
                    dist[v] = dist[u] + w + 1;
                    pq.emplace(dist[v], v);
                }
            }
        }

        int reachable = count_if(dist.begin(), dist.end(), [&](int d) { return d <= maxMoves; });
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            int reachableInEdge = max(0, min(maxMoves - dist[u], maxMoves - dist[v]));
            reachable += reachableInEdge;
        }

        return reachable;
    }
};