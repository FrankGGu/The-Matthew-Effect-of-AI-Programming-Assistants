#include <vector>
#include <numeric>
#include <algorithm>

class DSU {
public:
    std::vector<int> parent;
    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0);
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
            parent[root_i] = root_j;
            return true;
        }
        return false;
    }
};

int calculate_mst(int n, const std::vector<std::vector<int>>& edges, int exclude_idx, int include_idx) {
    DSU dsu(n);
    int mst_weight = 0;
    int edges_count = 0;

    if (include_idx != -1) {
        for (const auto& edge : edges) {
            if (edge[3] == include_idx) {
                if (dsu.unite(edge[1], edge[2])) {
                    mst_weight += edge[0];
                    edges_count++;
                }
                break;
            }
        }
    }

    for (const auto& edge : edges) {
        if (edge[3] == exclude_idx) {
            continue;
        }
        if (edge[3] == include_idx) {
            continue;
        }

        if (dsu.unite(edge[1], edge[2])) {
            mst_weight += edge[0];
            edges_count++;
        }
    }

    if (edges_count != n - 1) {
        return -1;
    }

    return mst_weight;
}

class Solution {
public:
    std::vector<std::vector<int>> findCriticalAndPseudoCriticalEdges(int n, std::vector<std::vector<int>>& edges) {
        std::vector<std::vector<int>> indexed_edges;
        for (int i = 0; i < edges.size(); ++i) {
            indexed_edges.push_back({edges[i][2], edges[i][0], edges[i][1], i}); // {weight, u, v, original_index}
        }

        std::sort(indexed_edges.begin(), indexed_edges.end());

        int min_mst_weight = calculate_mst(n, indexed_edges, -1, -1);

        std::vector<int> critical_edges;
        std::vector<int> pseudo_critical_edges;

        for (int i = 0; i < indexed_edges.size(); ++i) {
            int original_idx = indexed_edges[i][3];

            int mst_weight_excluding_current = calculate_mst(n, indexed_edges, original_idx, -1);
            if (mst_weight_excluding_current == -1 || mst_weight_excluding_current > min_mst_weight) {
                critical_edges.push_back(original_idx);
            } else {
                int mst_weight_including_current = calculate_mst(n, indexed_edges, -1, original_idx);
                if (mst_weight_including_current == min_mst_weight) {
                    pseudo_critical_edges.push_back(original_idx);
                }
            }
        }

        return {critical_edges, pseudo_critical_edges};
    }
};