#include <vector>
#include <utility>
#include <algorithm>
#include <cmath>
#include <functional>

class Solution {
public:
    std::vector<int> minEdgeWeightEquilibriumQueries(int n, std::vector<std::vector<int>>& edges, std::vector<std::vector<int>>& queries) {
        int LOGN = 0;
        while ((1 << LOGN) < n) {
            LOGN++;
        }

        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        std::vector<int> depth(n, 0);
        std::vector<int> dist_xor(n, 0);
        std::vector<std::vector<int>> parent(n, std::vector<int>(LOGN, -1));
        std::vector<std::vector<int>> max_w_up(n, std::vector<int>(LOGN, 0));

        std::function<void(int, int, int, int, int)> dfs = 
            [&](int u, int p, int d, int current_xor, int w_to_p) {
            depth[u] = d;
            dist_xor[u] = current_xor;
            parent[u][0] = p;
            max_w_up[u][0] = w_to_p;
            for (auto& edge : adj[u]) {
                int v = edge.first;
                int w = edge.second;
                if (v != p) {
                    dfs(v, u, d + 1, current_xor ^ w, w);
                }
            }
        };

        dfs(0, -1, 0, 0, 0);

        for (int i = 1; i < LOGN; ++i) {
            for (int u = 0; u < n; ++u) {
                if (parent[u][i - 1] != -1) {
                    int p = parent[u][i - 1];
                    parent[u][i] = parent[p][i - 1];
                    if (parent[u][i] != -1) {
                        max_w_up[u][i] = std::max(max_w_up[u][i - 1], max_w_up[p][i - 1]);
                    }
                }
            }
        }

        std::vector<int> ans;
        ans.reserve(queries.size());
        for (const auto& q : queries) {
            int u = q[0], v = q[1];

            if (u == v) {
                ans.push_back(0);
                continue;
            }

            if ((dist_xor[u] ^ dist_xor[v]) != 0) {
                ans.push_back(-1);
                continue;
            }

            int max_w = 0;
            if (depth[u] < depth[v]) {
                std::swap(u, v);
            }

            int diff = depth[u] - depth[v];
            for (int i = 0; i < LOGN; ++i) {
                if ((diff >> i) & 1) {
                    max_w = std::max(max_w, max_w_up[u][i]);
                    u = parent[u][i];
                }
            }

            if (u == v) {
                ans.push_back(max_w);
                continue;
            }

            for (int i = LOGN - 1; i >= 0; --i) {
                if (parent[u][i] != -1 && parent[u][i] != parent[v][i]) {
                    max_w = std::max({max_w, max_w_up[u][i], max_w_up[v][i]});
                    u = parent[u][i];
                    v = parent[v][i];
                }
            }

            max_w = std::max({max_w, max_w_up[u][0], max_w_up[v][0]});
            ans.push_back(max_w);
        }

        return ans;
    }
};