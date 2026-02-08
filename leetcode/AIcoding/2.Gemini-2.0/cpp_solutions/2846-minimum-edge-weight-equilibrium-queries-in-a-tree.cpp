#include <vector>

using namespace std;

class Solution {
public:
    vector<int> minOperationsQueries(int n, vector<vector<int>>& edges, vector<vector<int>>& queries) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        int logN = 0;
        while ((1 << logN) <= n) {
            logN++;
        }

        vector<vector<int>> parent(n, vector<int>(logN, -1));
        vector<vector<vector<int>>> weight_counts(n, vector<vector<int>>(logN, vector<int>(27, 0)));
        vector<int> depth(n, 0);

        function<void(int, int, int)> dfs = [&](int u, int p, int d) {
            parent[u][0] = p;
            depth[u] = d;

            for (auto& neighbor : adj[u]) {
                int v = neighbor.first;
                int w = neighbor.second;
                if (v != p) {
                    weight_counts[v][0][w]++;
                    dfs(v, u, d + 1);
                }
            }
        };

        dfs(0, -1, 0);

        for (int j = 1; j < logN; ++j) {
            for (int i = 0; i < n; ++i) {
                if (parent[i][j - 1] != -1) {
                    parent[i][j] = parent[parent[i][j - 1]][j - 1];
                    for (int k = 1; k <= 26; ++k) {
                        weight_counts[i][j][k] = weight_counts[i][j - 1][k] + weight_counts[parent[i][j - 1]][j - 1][k];
                    }
                }
            }
        }

        auto lca = [&](int u, int v) {
            if (depth[u] < depth[v]) {
                swap(u, v);
            }

            for (int i = logN - 1; i >= 0; --i) {
                if (depth[u] - (1 << i) >= depth[v]) {
                    u = parent[u][i];
                }
            }

            if (u == v) {
                return u;
            }

            for (int i = logN - 1; i >= 0; --i) {
                if (parent[u][i] != -1 && parent[u][i] != parent[v][i]) {
                    u = parent[u][i];
                    v = parent[v][i];
                }
            }

            return parent[u][0];
        };

        auto get_weight_counts = [&](int u, int lca_node) {
            vector<int> counts(27, 0);
            int diff = depth[u] - depth[lca_node];
            for (int i = logN - 1; i >= 0; --i) {
                if ((diff >> i) & 1) {
                    for (int k = 1; k <= 26; ++k) {
                        counts[k] += weight_counts[u][i][k];
                    }
                    u = parent[u][i];
                }
            }
            return counts;
        };

        vector<int> result;
        for (auto& query : queries) {
            int u = query[0];
            int v = query[1];
            int lca_node = lca(u, v);
            vector<int> counts_u = get_weight_counts(u, lca_node);
            vector<int> counts_v = get_weight_counts(v, lca_node);

            vector<int> counts_lca(27, 0);
            int diff = depth[lca_node];

            for (int i = logN - 1; i >= 0; --i) {
                if ((diff >> i) & 1 && parent[lca_node][i] != -1) {
                    for (int k = 1; k <= 26; ++k) {
                        counts_lca[k] += weight_counts[lca_node][i][k];
                    }
                    lca_node = parent[lca_node][i];
                }
            }

            int total_edges = depth[query[0]] + depth[query[1]] - 2 * depth[lca(query[0], query[1])];
            int max_weight_count = 0;
            for (int i = 1; i <= 26; ++i) {
                max_weight_count = max(max_weight_count, counts_u[i] + counts_v[i]);
            }
            result.push_back(total_edges - max_weight_count);
        }

        return result;
    }
};