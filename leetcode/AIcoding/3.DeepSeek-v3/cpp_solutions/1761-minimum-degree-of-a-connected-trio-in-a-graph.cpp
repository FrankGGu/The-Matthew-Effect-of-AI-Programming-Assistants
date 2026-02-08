class Solution {
public:
    int minTrioDegree(int n, vector<vector<int>>& edges) {
        vector<unordered_set<int>> adj(n + 1);
        vector<int> degree(n + 1, 0);

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].insert(v);
            adj[v].insert(u);
            degree[u]++;
            degree[v]++;
        }

        int min_degree = INT_MAX;

        for (int u = 1; u <= n; ++u) {
            for (int v : adj[u]) {
                if (v > u) {
                    for (int w : adj[v]) {
                        if (w > v && adj[u].count(w)) {
                            int trio_degree = degree[u] + degree[v] + degree[w] - 6;
                            min_degree = min(min_degree, trio_degree);
                        }
                    }
                }
            }
        }

        return min_degree == INT_MAX ? -1 : min_degree;
    }
};