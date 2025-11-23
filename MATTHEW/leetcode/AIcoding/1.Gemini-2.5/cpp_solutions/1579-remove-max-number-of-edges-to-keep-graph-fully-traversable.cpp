#include <vector>
#include <numeric>
#include <algorithm>

class DSU {
public:
    std::vector<int> parent;
    std::vector<int> sz;
    int num_components;

    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0);
        sz.assign(n, 1);
        num_components = n;
    }

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]);
    }

    bool unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            if (sz[root_i] < sz[root_j]) std::swap(root_i, root_j);
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
            num_components--;
            return true;
        }
        return false;
    }
};

class Solution {
public:
    int maxNumEdgesToRemove(int n, std::vector<std::vector<int>>& edges) {
        DSU dsu_alice(n);
        DSU dsu_bob(n);
        int edges_used = 0;

        for (const auto& edge : edges) {
            if (edge[0] == 3) {
                int u = edge[1] - 1;
                int v = edge[2] - 1;
                bool alice_united = dsu_alice.unite(u, v);
                bool bob_united = dsu_bob.unite(u, v);
                if (alice_united || bob_united) {
                    edges_used++;
                }
            }
        }

        for (const auto& edge : edges) {
            if (edge[0] == 1) {
                int u = edge[1] - 1;
                int v = edge[2] - 1;
                if (dsu_alice.unite(u, v)) {
                    edges_used++;
                }
            }
        }

        for (const auto& edge : edges) {
            if (edge[0] == 2) {
                int u = edge[1] - 1;
                int v = edge[2] - 1;
                if (dsu_bob.unite(u, v)) {
                    edges_used++;
                }
            }
        }

        if (dsu_alice.num_components != 1 || dsu_bob.num_components != 1) {
            return -1;
        }

        return edges.size() - edges_used;
    }
};