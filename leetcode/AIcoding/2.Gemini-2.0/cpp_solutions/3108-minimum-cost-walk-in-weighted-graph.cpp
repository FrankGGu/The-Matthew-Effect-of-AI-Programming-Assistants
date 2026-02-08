#include <vector>
#include <queue>
#include <climits>

using namespace std;

struct Edge {
    int to;
    int cost;
};

int minCostWalk(int n, vector<vector<int>>& edges, int start, int target, int max_edges) {
    vector<vector<Edge>> adj(n);
    for (auto& edge : edges) {
        adj[edge[0]].push_back({edge[1], edge[2]});
    }

    vector<vector<int>> dist(n, vector<int>(max_edges + 1, INT_MAX));
    dist[start][0] = 0;

    priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
    pq.emplace(0, start, 0);

    while (!pq.empty()) {
        auto [d, u, edges_used] = pq.top();
        pq.pop();

        if (d > dist[u][edges_used]) continue;

        if (u == target) {
            return d;
        }

        if (edges_used == max_edges) continue;

        for (auto& edge : adj[u]) {
            int v = edge.to;
            int cost = edge.cost;

            if (dist[v][edges_used + 1] > d + cost) {
                dist[v][edges_used + 1] = d + cost;
                pq.emplace(d + cost, v, edges_used + 1);
            }
        }
    }

    int min_cost = INT_MAX;
    for (int i = 0; i <= max_edges; ++i) {
        min_cost = min(min_cost, dist[target][i]);
    }

    return (min_cost == INT_MAX) ? -1 : min_cost;
}