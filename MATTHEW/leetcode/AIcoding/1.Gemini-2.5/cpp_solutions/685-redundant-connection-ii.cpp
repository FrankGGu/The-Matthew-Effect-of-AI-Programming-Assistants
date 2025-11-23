#include <vector>
#include <numeric> // For std::iota

class DSU {
private:
    std::vector<int> parent;
    std::vector<int> rank;

public:
    DSU(int n) {
        parent.resize(n + 1);
        std::iota(parent.begin(), parent.end(), 0); 
        rank.assign(n + 1, 0); 
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
        return false; // Cycle detected
    }
};

class Solution {
private:
    std::vector<int> findCycleEdge(int n, const std::vector<std::vector<int>>& edges_to_consider) {
        DSU dsu(n);
        for (const auto& edge : edges_to_consider) {
            int u = edge[0];
            int v = edge[1];
            if (!dsu.unite(u, v)) {
                return edge;
            }
        }
        return {}; // No cycle found
    }

public:
    std::vector<int> findRedundantDirectedConnection(std::vector<std::vector<int>>& edges) {
        int n = edges.size();

        std::vector<int> inDegree(n + 1, 0);
        std::vector<int> parent_map(n + 1, 0);

        std::vector<int> candidate1 = {-1, -1};
        std::vector<int> candidate2 = {-1, -1};

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            inDegree[v]++;
            if (inDegree[v] == 2) {
                candidate1 = {parent_map[v], v};
                candidate2 = edge;
                break; 
            }
            parent_map[v] = u;
        }

        if (candidate1[0] == -1) {
            return findCycleEdge(n, edges);
        } else {
            std::vector<std::vector<int>> temp_edges;
            for (const auto& edge : edges) {
                if (!(edge[0] == candidate2[0] && edge[1] == candidate2[1])) {
                    temp_edges.push_back(edge);
                }
            }

            std::vector<int> cycle_edge = findCycleEdge(n, temp_edges);

            if (cycle_edge.empty()) {
                return candidate2;
            } else {
                return candidate1;
            }
        }
        return {};
    }
};