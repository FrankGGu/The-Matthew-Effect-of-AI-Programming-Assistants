#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> parent;
    std::vector<int> rank;

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]);
    }

    bool unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            if (rank[root_i] < rank[root_j])
                parent[root_i] = root_j;
            else if (rank[root_i] > rank[root_j])
                parent[root_j] = root_i;
            else {
                parent[root_j] = root_i;
                rank[root_i]++;
            }
            return true;
        }
        return false;
    }

    std::vector<int> findRedundantConnection(std::vector<std::vector<int>>& edges) {
        int n = edges.size();
        parent.resize(n + 1);
        std::iota(parent.begin(), parent.end(), 0);
        rank.assign(n + 1, 0);

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            if (!unite(u, v)) {
                return edge;
            }
        }
        return {}; 
    }
};