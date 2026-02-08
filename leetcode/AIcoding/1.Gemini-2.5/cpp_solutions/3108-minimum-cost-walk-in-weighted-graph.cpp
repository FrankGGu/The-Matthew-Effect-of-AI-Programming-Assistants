#include <iostream>
#include <vector>
#include <numeric>
#include <map>

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
            parent[root_j] = root_i;
        }
    }
};

class Solution {
public:
    std::vector<int> minimumCost(int n, std::vector<std::vector<int>>& edges, std::vector<std::vector<int>>& query) {
        std::vector<int> q_indices(query.size());
        std::iota(q_indices.begin(), q_indices.end(), 0);

        std::map<int, std::vector<int>> groups;
        groups[0] = q_indices;

        for (int b = 29; b >= 0; --b) {
            std::map<int, std::vector<int>> next_groups;
            for (auto const& [mask, indices] : groups) {
                int potential_mask = mask | (1 << b);

                DSU dsu(n);
                for (const auto& edge : edges) {
                    if ((edge[2] & potential_mask) == potential_mask) {
                        dsu.unite(edge[0], edge[1]);
                    }
                }

                std::vector<int> pass_group;
                std::vector<int> fail_group;

                for (int idx : indices) {
                    if (dsu.find(query[idx][0]) == dsu.find(query[idx][1])) {
                        pass_group.push_back(idx);
                    } else {
                        fail_group.push_back(idx);
                    }
                }

                if (!pass_group.empty()) {
                    next_groups[potential_mask].insert(next_groups[potential_mask].end(), pass_group.begin(), pass_group.end());
                }
                if (!fail_group.empty()) {
                    next_groups[mask].insert(next_groups[mask].end(), fail_group.begin(), fail_group.end());
                }
            }
            groups = next_groups;
        }

        std::vector<int> ans(query.size());
        for (auto const& [mask, indices] : groups) {
            for (int idx : indices) {
                ans[idx] = mask;
            }
        }

        DSU overall_dsu(n);
        for(const auto& edge : edges) {
            overall_dsu.unite(edge[0], edge[1]);
        }
        for(size_t i = 0; i < query.size(); ++i) {
            if(overall_dsu.find(query[i][0]) != overall_dsu.find(query[i][1])) {
                ans[i] = -1;
            }
        }

        return ans;
    }
};