#include <vector>
#include <algorithm>
#include <numeric>

class DSU {
public:
    std::vector<int> parent;
    int num_components;

    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0);
        num_components = n;
    }

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]);
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            parent[root_i] = root_j;
            num_components--;
        }
    }
};

class Solution {
public:
    int minMaxEdgeWeight(int n, std::vector<std::vector<int>>& edges) {
        if (n <= 1) {
            return 0;
        }

        std::sort(edges.begin(), edges.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[2] < b[2];
        });

        DSU dsu(n);
        int max_mst_weight = 0;

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int weight = edge[2];

            if (dsu.find(u) != dsu.find(v)) {
                dsu.unite(u, v);
                max_mst_weight = std::max(max_mst_weight, weight);

                if (dsu.num_components == 1) {
                    break;
                }
            }
        }

        return max_mst_weight;
    }
};