#include <vector>
#include <numeric>
#include <functional>

class Solution {
public:
    std::vector<bool> pathExists(int n, std::vector<std::vector<int>>& edges, std::vector<std::vector<int>>& queries) {
        std::vector<int> parent(n);
        std::iota(parent.begin(), parent.end(), 0);
        std::vector<int> sz(n, 1);

        std::function<int(int)> find = [&](int i) {
            if (parent[i] == i) {
                return i;
            }
            return parent[i] = find(parent[i]);
        };

        auto unite = [&](int i, int j) {
            int root_i = find(i);
            int root_j = find(j);
            if (root_i != root_j) {
                if (sz[root_i] < sz[root_j]) {
                    std::swap(root_i, root_j);
                }
                parent[root_j] = root_i;
                sz[root_i] += sz[root_j];
            }
        };

        for (const auto& edge : edges) {
            unite(edge[0], edge[1]);
        }

        std::vector<bool> ans;
        ans.reserve(queries.size());
        for (const auto& query : queries) {
            ans.push_back(find(query[0]) == find(query[1]));
        }

        return ans;
    }
};