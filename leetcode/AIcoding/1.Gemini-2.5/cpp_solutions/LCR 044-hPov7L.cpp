#include <vector>
#include <queue>
#include <algorithm> // For std::max
#include <limits>    // For std::numeric_limits

class Solution {
public:
    std::vector<int> largestValues(TreeNode* root) {
        std::vector<int> results;
        if (!root) {
            return results;
        }

        std::queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            int level_size = q.size();
            int max_val_in_level = std::numeric_limits<int>::min();

            for (int i = 0; i < level_size; ++i) {
                TreeNode* current_node = q.front();
                q.pop();

                max_val_in_level = std::max(max_val_in_level, current_node->val);

                if (current_node->left) {
                    q.push(current_node->left);
                }
                if (current_node->right) {
                    q.push(current_node->right);
                }
            }
            results.push_back(max_val_in_level);
        }

        return results;
    }
};