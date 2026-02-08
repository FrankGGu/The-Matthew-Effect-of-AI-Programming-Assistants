class Solution {
public:
    vector<int> minOperationsQueries(int n, vector<vector<int>>& edges, vector<vector<int>>& queries) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& e : edges) {
            int u = e[0], v = e[1], w = e[2];
            adj[u].emplace_back(v, w);
            adj[v].emplace_back(u, w);
        }

        const int LOG = 14;
        vector<vector<int>> up(n, vector<int>(LOG, -1));
        vector<int> depth(n, 0);
        vector<vector<array<int, 26>>> cnt(n, vector<array<int, 26>>(LOG));

        function<void(int, int)> dfs = [&](int u, int p) {
            up[u][0] = p;
            for (int k = 1; k < LOG; ++k) {
                if (up[u][k-1] == -1) break;
                up[u][k] = up[up[u][k-1]][k-1];
                for (int w = 1; w <= 26; ++w) {
                    cnt[u][k][w-1] = cnt[u][k-1][w-1] + cnt[up[u][k-1]][k-1][w-1];
                }
            }
            for (auto [v, w] : adj[u]) {
                if (v == p) continue;
                depth[v] = depth[u] + 1;
                cnt[v][0][w-1] = 1;
                dfs(v, u);
            }
        };
        dfs(0, -1);

        auto lca = [&](int u, int v) {
            if (depth[u] < depth[v]) swap(u, v);
            for (int k = LOG-1; k >= 0; --k) {
                if (depth[u] - (1 << k) >= depth[v]) {
                    u = up[u][k];
                }
            }
            if (u == v) return u;
            for (int k = LOG-1; k >= 0; --k) {
                if (up[u][k] != -1 && up[u][k] != up[v][k]) {
                    u = up[u][k];
                    v = up[v][k];
                }
            }
            return up[u][0];
        };

        vector<int> res;
        for (auto& q : queries) {
            int u = q[0], v = q[1];
            int ancestor = lca(u, v);
            array<int, 26> total{};

            auto add = [&](int node, int anc) {
                for (int k = LOG-1; k >= 0; --k) {
                    if (depth[node] - (1 << k) >= depth[anc]) {
                        for (int w = 0; w < 26; ++w) {
                            total[w] += cnt[node][k][w];
                        }
                        node = up[node][k];
                    }
                }
            };
            add(u, ancestor);
            add(v, ancestor);

            int sum = accumulate(total.begin(), total.end(), 0);
            int max_freq = *max_element(total.begin(), total.end());
            res.push_back(sum - max_freq);
        }
        return res;
    }
};