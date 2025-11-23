#include <vector>
#include <functional>

class Solution {
public:
    std::vector<int> smallestMissingValueSubtree(std::vector<int>& parents, std::vector<int>& nums) {
        int n = parents.size();
        std::vector<std::vector<int>> children(n);
        for (int i = 1; i < n; ++i) {
            children[parents[i]].push_back(i);
        }

        std::vector<int> ans(n, 1);

        int node_one_idx = -1;
        for (int i = 0; i < n; ++i) {
            if (nums[i] == 1) {
                node_one_idx = i;
                break;
            }
        }

        if (node_one_idx == -1) {
            return ans;
        }

        std::vector<bool> seen(n + 2, false);
        int missing = 1;

        std::function<void(int)> dfs = [&](int u) {
            if (nums[u] < seen.size() && !seen[nums[u]]) {
                seen[nums[u]] = true;
                for (int v : children[u]) {
                    dfs(v);
                }
            }
        };

        int current_node = node_one_idx;
        int prev_node = -1;

        while (current_node != -1) {
            for (int child : children[current_node]) {
                if (child != prev_node) {
                    dfs(child);
                }
            }
            if (nums[current_node] < seen.size()) {
                seen[nums[current_node]] = true;
            }

            while (missing < seen.size() && seen[missing]) {
                missing++;
            }
            ans[current_node] = missing;

            prev_node = current_node;
            current_node = parents[current_node];
        }

        return ans;
    }
};