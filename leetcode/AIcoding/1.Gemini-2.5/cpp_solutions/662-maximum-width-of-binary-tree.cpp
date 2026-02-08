#include <queue>
#include <algorithm> // For std::max

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    int widthOfBinaryTree(TreeNode* root) {
        if (!root) {
            return 0;
        }

        unsigned long long max_width = 1;
        std::queue<std::pair<TreeNode*, unsigned long long>> q;
        q.push({root, 0});

        while (!q.empty()) {
            int level_size = q.size();
            // The first node's index at the current level.
            // Due to normalization, this will always be 0 for the first node pushed to the queue for this level.
            unsigned long long first_idx_at_level = q.front().second; 

            // To store the maximum relative index encountered at the current level.
            unsigned long long current_level_max_idx = 0; 

            for (int i = 0; i < level_size; ++i) {
                TreeNode* curr_node = q.front().first;
                unsigned long long curr_idx_relative = q.front().second;
                q.pop();

                current_level_max_idx = curr_idx_relative;

                if (curr_node->left) {
                    // Assign index to left child: 2 * (parent's relative index)
                    q.push({curr_node->left, 2 * curr_idx_relative});
                }
                if (curr_node->right) {
                    // Assign index to right child: 2 * (parent's relative index) + 1
                    q.push({curr_node->right, 2 * curr_idx_relative + 1});
                }
            }
            // Calculate the width of the current level: (last_node_index - first_node_index + 1)
            // Since first_idx_at_level is always 0 due to our normalization, this simplifies to (current_level_max_idx + 1)
            max_width = std::max(max_width, current_level_max_idx - first_idx_at_level + 1);
        }

        return static_cast<int>(max_width);
    }
};