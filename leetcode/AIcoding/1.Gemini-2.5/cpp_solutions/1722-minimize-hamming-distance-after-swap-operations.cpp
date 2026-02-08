#include <vector>
#include <numeric>
#include <map>
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
    int minHammingDistance(std::vector<int>& source, std::vector<int>& target, std::vector<std::vector<int>>& allowedSwaps) {
        int n = source.size();
        DSU dsu(n);

        for (const auto& swap_pair : allowedSwaps) {
            dsu.unite(swap_pair[0], swap_pair[1]);
        }

        std::map<int, std::map<int, int>> source_counts_per_component;
        std::map<int, std::map<int, int>> target_counts_per_component;

        for (int i = 0; i < n; ++i) {
            int root = dsu.find(i);
            source_counts_per_component[root][source[i]]++;
            target_counts_per_component[root][target[i]]++;
        }

        int total_matches = 0;
        for (auto const& [root, s_counts] : source_counts_per_component) {
            const auto& t_counts = target_counts_per_component[root];
            for (auto const& [num, count_s] : s_counts) {
                int count_t = 0;
                auto it = t_counts.find(num);
                if (it != t_counts.end()) {
                    count_t = it->second;
                }
                total_matches += std::min(count_s, count_t);
            }
        }

        return n - total_matches;
    }
};