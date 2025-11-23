#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> parent;

    int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            parent[root_j] = root_i;
        }
    }

    std::vector<int> findRedundantConnection(std::vector<std::vector<int>>& edges) {
        int n = edges.size();
        parent.resize(n + 1);
        std::iota(parent.begin(), parent.end(), 0); // Initialize parent[i] = i for all i

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            if (find(u) == find(v)) {
                return edge;
            }
            unite(u, v);
        }
        return {}; // Should not be reached based on problem description
    }
};