#include <queue>
#include <vector>
#include <algorithm>
#include <utility>

class Solution {
public:
    int minimumOperations(TreeNode* root) {
        if (!root) {
            return 0;
        }

        int total_swaps = 0;
        std::queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            int level_size = q.size();
            std::vector<int> current_level_values;
            current_level_values.reserve(level_size);

            for (int i = 0; i < level_size; ++i) {
                TreeNode* node = q.front();
                q.pop();
                current_level_values.push_back(node->val);

                if (node->left) {
                    q.push(node->left);
                }
                if (node->right) {
                    q.push(node->right);
                }
            }

            int n = current_level_values.size();
            if (n <= 1) {
                continue;
            }

            std::vector<std::pair<int, int>> indexed_values(n);
            for (int i = 0; i < n; ++i) {
                indexed_values[i] = {current_level_values[i], i};
            }

            std::sort(indexed_values.begin(), indexed_values.end());

            std::vector<bool> visited(n, false);
            int level_swaps = 0;

            for (int i = 0; i < n; ++i) {
                if (visited[i] || indexed_values[i].second == i) {
                    continue;
                }

                int cycle_size = 0;
                int j = i;
                while (!visited[j]) {
                    visited[j] = true;
                    j = indexed_values[j].second;
                    cycle_size++;
                }
                if (cycle_size > 0) {
                    level_swaps += (cycle_size - 1);
                }
            }
            total_swaps += level_swaps;
        }

        return total_swaps;
    }
};