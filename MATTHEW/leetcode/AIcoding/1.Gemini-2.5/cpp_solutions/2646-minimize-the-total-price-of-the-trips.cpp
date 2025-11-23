#include <vector>
#include <algorithm>

class Solution {
public:
    static const int N_MAX = 100005;
    static const int LOG_N_MAX = 18; // ceil(log2(N_MAX))

    std::vector<int> adj[N_MAX];
    int parent[N_MAX][LOG_N_MAX];
    int depth[N_MAX];
    long long freq[N_MAX];
    long long dp[N_MAX][2];

    void dfs_lca_init(int u, int p, int d) {
        depth[u] = d;
        parent[u][0] = p;
        for (int k = 1; k < LOG_N_MAX; ++k) {
            if (parent[u][k-1] != -1) {
                parent[u][k] = parent[parent[u][k-1]][k-1];
            } else {
                parent[u][k] = -1;
            }
        }
        for (int v : adj[u]) {
            if (v != p) {
                dfs_lca_init(v, u, d + 1);
            }
        }
    }

    int get_lca(int u, int v) {
        if (depth[u] < depth[v]) {
            std::swap(u, v);
        }

        for (int k = LOG_N_MAX - 1; k >= 0; --k) {
            if (parent[u][k] != -1 && depth[u] - (1 << k) >= depth[v]) {
                u = parent[u][k];
            }
        }

        if (u == v) {
            return u;
        }

        for (int k = LOG_N_MAX - 1; k >= 0; --k) {
            if (parent[u][k] != -1 && parent[v][k] != -1 && parent[u][k] != parent[v][k]) {
                u = parent[u][k];
                v = parent[v][k];
            }
        }
        return parent[u][0];
    }

    void dfs_count_paths(int u, int p) {
        for (int v : adj[u]) {
            if (v != p) {
                dfs_count_paths(v, u);
                freq[u] += freq[v];
            }
        }
    }

    void dfs_dp(int u, int p, const std::vector<int>& prices) {
        long long cost0 = (long long)prices[u] * freq[u];
        long long cost1 = (long long)(prices[u] / 2) * freq[u];

        for (int v : adj[u]) {
            if (v != p) {
                dfs_dp(v, u, prices);
                cost0 += std::min(dp[v][0], dp[v][1]);
                cost1 += dp[v][0];
            }
        }
        dp[u][0] = cost0;
        dp[u][1] = cost1;
    }

    int minimizeTotalPrice(int n, std::vector<std::vector<int>>& edges, std::vector<int>& price, std::vector<std::vector<int>>& trips) {
        for (int i = 0; i < n; ++i) {
            adj[i].clear();
            freq[i] = 0;
            dp[i][0] = 0;
            dp[i][1] = 0;
            depth[i] = 0;
            for(int k=0; k<LOG_N_MAX; ++k) parent[i][k] = -1;
        }

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        dfs_lca_init(0, -1, 0);

        for (const auto& trip : trips) {
            int u = trip[0];
            int v = trip[1];
            int lca = get_lca(u, v);
            freq[u]++;
            freq[v]++;
            freq[lca]--;
            if (parent[lca][0] != -1) {
                freq[parent[lca][0]]--;
            }
        }

        dfs_count_paths(0, -1);

        dfs_dp(0, -1, price);

        return std::min(dp[0][0], dp[0][1]);
    }
};