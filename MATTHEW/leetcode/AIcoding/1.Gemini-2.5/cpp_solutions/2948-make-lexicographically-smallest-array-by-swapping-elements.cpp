#include <vector>
#include <numeric>
#include <algorithm>
#include <map>

class DSU {
public:
    std::vector<int> parent;
    std::vector<int> sz; // Using size for union by size optimization

    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0); // parent[i] = i
        sz.assign(n, 1); // size of each set is 1 initially
    }

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]); // Path compression
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            // Union by size
            if (sz[root_i] < sz[root_j])
                std::swap(root_i, root_j);
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
        }
    }
};

class Solution {
public:
    std::vector<int> makeLexicographicallySmallestArray(std::vector<int>& nums, int limit) {
        int n = nums.size();

        std::vector<std::pair<int, int>> val_idx_pairs(n);
        for (int i = 0; i < n; ++i) {
            val_idx_pairs[i] = {nums[i], i};
        }

        std::sort(val_idx_pairs.begin(), val_idx_pairs.end());

        DSU dsu(n);

        for (int i = 0; i < n - 1; ++i) {
            if (val_idx_pairs[i+1].first - val_idx_pairs[i].first <= limit) {
                dsu.unite(val_idx_pairs[i].second, val_idx_pairs[i+1].second);
            }
        }

        std::map<int, std::vector<int>> component_indices;
        std::map<int, std::vector<int>> component_values;
        for (int i = 0; i < n; ++i) {
            int root = dsu.find(i);
            component_indices[root].push_back(i);
            component_values[root].push_back(nums[i]);
        }

        std::vector<int> ans(n);
        for (auto const& [root, indices] : component_indices) {
            std::vector<int> current_indices = indices;
            std::vector<int> current_values = component_values[root];

            std::sort(current_indices.begin(), current_indices.end());
            std::sort(current_values.begin(), current_values.end());

            for (int k = 0; k < current_indices.size(); ++k) {
                ans[current_indices[k]] = current_values[k];
            }
        }

        return ans;
    }
};