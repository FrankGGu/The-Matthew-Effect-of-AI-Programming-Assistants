#include <vector>
#include <numeric> // For std::iota
#include <set>     // For std::set

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

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            parent[root_i] = root_j;
        }
    }
};

class Solution {
public:
    int removeStones(std::vector<std::vector<int>>& stones) {
        int n = stones.size();
        if (n <= 1) {
            return 0;
        }

        // Max coordinate value is 10000.
        // We map row `r` to ID `r`.
        // We map column `c` to ID `c + OFFSET`. A safe OFFSET is 10001.
        // This ensures row and column IDs do not overlap.
        // Row IDs will range from 0 to 10000.
        // Column IDs will range from 10001 to 20001.
        // So, the DSU structure needs to accommodate IDs up to 20001,
        // meaning its size should be 20002.
        DSU dsu(20002); 

        std::set<int> unique_nodes_involved; // Stores all unique row/column IDs that have stones

        for (const auto& stone : stones) {
            int r = stone[0];
            int c = stone[1];
            int col_id = c + 10001; // Offset column ID

            dsu.unite(r, col_id);
            unique_nodes_involved.insert(r);
            unique_nodes_involved.insert(col_id);
        }

        // Count the number of unique roots among the nodes that were actually involved.
        // Each unique root represents a connected component.
        std::set<int> roots_found;
        for (int node_id : unique_nodes_involved) {
            roots_found.insert(dsu.find(node_id));
        }
        int num_components = roots_found.size();

        // In each connected component of stones, all but one stone can be removed.
        // Therefore, the maximum number of stones that can be removed is
        // (total number of stones) - (number of connected components).
        return n - num_components;
    }
};