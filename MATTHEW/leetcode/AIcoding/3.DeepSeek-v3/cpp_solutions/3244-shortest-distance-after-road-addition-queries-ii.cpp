class Solution {
public:
    vector<long long> minCost(int n, vector<vector<int>>& roads, vector<vector<int>>& queries) {
        vector<vector<pair<int, int>>> adj(n + 1);
        for (auto& road : roads) {
            int u = road[0], v = road[1], w = road[2];
            adj[u].emplace_back(v, w);
            adj[v].emplace_back(u, w);
        }

        vector<vector<long long>> dist(n + 1, vector<long long>(n + 1, LLONG_MAX / 2));
        for (int i = 1; i <= n; ++i) {
            dist[i][i] = 0;
            priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
            pq.emplace(0, i);
            while (!pq.empty()) {
                auto [d, u] = pq.top();
                pq.pop();
                if (d > dist[i][u]) continue;
                for (auto [v, w] : adj[u]) {
                    if (dist[i][v] > dist[i][u] + w) {
                        dist[i][v] = dist[i][u] + w;
                        pq.emplace(dist[i][v], v);
                    }
                }
            }
        }

        vector<long long> res;
        for (auto& query : queries) {
            int u = query[0], v = query[1];
            res.push_back(dist[u][v] == LLONG_MAX / 2 ? -1 : dist[u][v]);
        }
        return res;
    }
};