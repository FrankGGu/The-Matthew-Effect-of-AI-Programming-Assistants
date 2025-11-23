#include <vector>
#include <numeric>
#include <functional>
#include <algorithm>

class Solution {
public:
    std::vector<int> getCoprimes(std::vector<int>& nums, std::vector<std::vector<int>>& edges) {
        int n = nums.size();
        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        std::vector<int> ans(n, -1);
        std::vector<std::pair<int, int>> path_val_info(51, {-1, -1}); // {depth, node_index}

        std::function<void(int, int, int)> dfs = 
            [&](int u, int p, int depth) {

            int max_depth = -1;
            int closest_ancestor = -1;

            for (int val = 1; val <= 50; ++val) {
                if (path_val_info[val].first != -1) {
                    if (std::gcd(nums[u], val) == 1) {
                        if (path_val_info[val].first > max_depth) {
                            max_depth = path_val_info[val].first;
                            closest_ancestor = path_val_info[val].second;
                        }
                    }
                }
            }
            ans[u] = closest_ancestor;

            std::pair<int, int> prev_info = path_val_info[nums[u]];
            path_val_info[nums[u]] = {depth, u};

            for (int v : adj[u]) {
                if (v != p) {
                    dfs(v, u, depth + 1);
                }
            }

            path_val_info[nums[u]] = prev_info;
        };

        dfs(0, -1, 0);
        return ans;
    }
};