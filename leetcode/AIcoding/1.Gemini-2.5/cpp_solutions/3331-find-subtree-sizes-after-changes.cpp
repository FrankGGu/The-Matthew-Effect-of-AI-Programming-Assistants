#include <vector>

class Solution {
private:
    class FenwickTree {
    private:
        std::vector<int> bit;
        int size;

    public:
        FenwickTree(int n) : size(n), bit(n + 1, 0) {}

        void update(int idx, int delta) {
            for (; idx <= size; idx += idx & (-idx)) {
                bit[idx] += delta;
            }
        }

        int query(int idx) {
            int sum = 0;
            for (; idx > 0; idx -= idx & (-idx)) {
                sum += bit[idx];
            }
            return sum;
        }

        int query_range(int l, int r) {
            return query(r) - query(l - 1);
        }
    };

    std::vector<std::vector<int>> adj;
    std::vector<int> tin;
    std::vector<int> tout;
    int timer;
    int N;

    void dfs(int u, int p) {
        tin[u] = ++timer;
        for (int v : adj[u]) {
            if (v != p) {
                dfs(v, u);
            }
        }
        tout[u] = timer;
    }

public:
    std::vector<int> findSubtreeSizesAfterChanges(int n, std::vector<std::vector<int>>& edges, std::vector<std::vector<int>>& queries) {
        N = n;
        adj.resize(N);
        tin.resize(N);
        tout.resize(N);
        timer = 0;

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        dfs(0, -1);

        FenwickTree ft(N);
        std::vector<bool> active(N, true);

        for (int i = 0; i < N; ++i) {
            ft.update(tin[i], 1);
        }

        std::vector<int> results;

        for (const auto& query : queries) {
            int type = query[0];
            int node_idx = query[1];

            if (type == 1) {
                int delta = active[node_idx] ? -1 : 1;
                ft.update(tin[node_idx], delta);
                active[node_idx] = !active[node_idx];
            } else {
                results.push_back(ft.query_range(tin[node_idx], tout[node_idx]));
            }
        }

        return results;
    }
};