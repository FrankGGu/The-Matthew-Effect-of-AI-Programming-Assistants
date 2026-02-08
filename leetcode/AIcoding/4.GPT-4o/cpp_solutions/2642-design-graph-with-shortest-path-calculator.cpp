class Graph {
public:
    unordered_map<int, vector<pair<int, int>>> adj;

    Graph() {}

    void addEdge(int u, int v, int w) {
        adj[u].emplace_back(v, w);
    }

    vector<int> shortestPath(int start, vector<int>& nodes) {
        unordered_map<int, int> dist;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;

        for (int node : nodes) {
            dist[node] = INT_MAX;
        }
        dist[start] = 0;
        pq.push({0, start});

        while (!pq.empty()) {
            auto [d, u] = pq.top(); pq.pop();
            if (d > dist[u]) continue;

            for (auto& [v, w] : adj[u]) {
                if (dist[u] + w < dist[v]) {
                    dist[v] = dist[u] + w;
                    pq.push({dist[v], v});
                }
            }
        }

        vector<int> result;
        for (int node : nodes) {
            result.push_back(dist[node] == INT_MAX ? -1 : dist[node]);
        }
        return result;
    }
};