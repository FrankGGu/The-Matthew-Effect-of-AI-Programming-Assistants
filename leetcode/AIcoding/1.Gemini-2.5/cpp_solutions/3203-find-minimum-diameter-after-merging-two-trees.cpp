#include <vector>
#include <queue>
#include <algorithm>
#include <climits>

std::vector<std::vector<int>> build_adj(int n, const std::vector<std::vector<int>>& edges) {
    std::vector<std::vector<int>> adj(n);
    for (const auto& edge : edges) {
        adj[edge[0]].push_back(edge[1]);
        adj[edge[1]].push_back(edge[0]);
    }
    return adj;
}

std::pair<int, std::vector<int>> bfs(int start_node, int n, const std::vector<std::vector<int>>& adj) {
    std::vector<int> dist(n, -1);
    std::queue<int> q;

    dist[start_node] = 0;
    q.push(start_node);

    int farthest_node = start_node;
    int max_dist = 0;

    while (!q.empty()) {
        int u = q.front();
        q.pop();

        if (dist[u] > max_dist) {
            max_dist = dist[u];
            farthest_node = u;
        }

        for (int v : adj[u]) {
            if (dist[v] == -1) {
                dist[v] = dist[u] + 1;
                q.push(v);
            }
        }
    }
    return {farthest_node, dist};
}

std::pair<int, int> get_diam_and_radius(int n, const std::vector<std::vector<int>>& adj) {
    if (n == 0) {
        return {0, 0};
    }
    if (n == 1) {
        return {0, 0};
    }

    std::pair<int, std::vector<int>> res1 = bfs(0, n, adj);
    int u = res1.first;

    std::pair<int, std::vector<int>> res2 = bfs(u, n, adj);
    int v = res2.first;
    std::vector<int> dist_from_u = res2.second;
    int diameter = dist_from_u[v];

    std::pair<int, std::vector<int>> res3 = bfs(v, n, adj);
    std::vector<int> dist_from_v = res3.second;

    int radius = INT_MAX;
    for (int i = 0; i < n; ++i) {
        int eccentricity_i = std::max(dist_from_u[i], dist_from_v[i]);
        radius = std::min(radius, eccentricity_i);
    }

    return {diameter, radius};
}

class Solution {
public:
    int getMinDiameter(int n1, std::vector<std::vector<int>>& edges1, int n2, std::vector<std::vector<int>>& edges2) {
        std::vector<std::vector<int>> adj1 = build_adj(n1, edges1);
        std::vector<std::vector<int>> adj2 = build_adj(n2, edges2);

        std::pair<int, int> tree1_info = get_diam_and_radius(n1, adj1);
        int diam1 = tree1_info.first;
        int rad1 = tree1_info.second;

        std::pair<int, int> tree2_info = get_diam_and_radius(n2, adj2);
        int diam2 = tree2_info.first;
        int rad2 = tree2_info.second;

        return std::max({diam1, diam2, rad1 + 1 + rad2});
    }
};