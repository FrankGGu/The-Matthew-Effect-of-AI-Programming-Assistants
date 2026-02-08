#include <vector>
#include <queue>
#include <tuple>

using namespace std;

int maxWeightedPath(int n, vector<vector<int>>& edges, int k) {
    vector<vector<pair<int, int>>> adj(n);
    for (auto& edge : edges) {
        int u = edge[0], v = edge[1], w = edge[2];
        adj[u].push_back({v, w});
    }

    vector<vector<int>> dist(n, vector<int>(k + 1, -1));
    dist[0][0] = 0;

    priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, less<tuple<int, int, int>>> pq;
    pq.push({0, 0, 0});

    while (!pq.empty()) {
        auto [d, u, steps] = pq.top();
        pq.pop();

        d = -d;

        if (d < dist[u][steps]) continue;

        if (steps == k) continue;

        for (auto& [v, w] : adj[u]) {
            if (dist[v][steps + 1] < d + w) {
                dist[v][steps + 1] = d + w;
                pq.push({-dist[v][steps + 1], v, steps + 1});
            }
        }
    }

    int max_weight = -1;
    for (int i = 0; i <= k; ++i) {
        max_weight = max(max_weight, dist[n - 1][i]);
    }

    return max_weight;
}