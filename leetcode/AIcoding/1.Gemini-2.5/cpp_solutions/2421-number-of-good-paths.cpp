#include <vector>
#include <numeric>
#include <algorithm>
#include <map>

class DSU {
public:
    std::vector<int> parent;
    std::vector<int> sz;

    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0);
        sz.assign(n, 1);
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
            if (sz[root_i] < sz[root_j])
                std::swap(root_i, root_j);
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
        }
    }
};

class Solution {
public:
    int numberOfGoodPaths(std::vector<int>& vals, std::vector<std::vector<int>>& edges) {
        int n = vals.size();
        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        std::map<int, std::vector<int>> nodes_by_value;
        for (int i = 0; i < n; ++i) {
            nodes_by_value[vals[i]].push_back(i);
        }

        DSU dsu(n);
        int goodPathsCount = 0;

        for (auto const& [value, nodes_list] : nodes_by_value) {
            for (int u : nodes_list) {
                for (int v : adj[u]) {
                    if (vals[v] <= vals[u]) {
                        dsu.unite(u, v);
                    }
                }
            }

            std::map<int, int> root_to_count_of_current_value_nodes;
            for (int u : nodes_list) {
                root_to_count_of_current_value_nodes[dsu.find(u)]++;
            }

            for (auto const& [root, count] : root_to_count_of_current_value_nodes) {
                goodPathsCount += count * (count + 1) / 2;
            }
        }

        return goodPathsCount;
    }
};