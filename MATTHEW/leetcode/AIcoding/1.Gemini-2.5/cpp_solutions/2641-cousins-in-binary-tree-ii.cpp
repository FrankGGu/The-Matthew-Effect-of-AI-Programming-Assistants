#include <queue>
#include <vector>
#include <map>
#include <utility> // For std::pair

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
    TreeNode* replaceValueInTree(TreeNode* root) {
        if (!root) {
            return nullptr;
        }

        std::queue<std::pair<TreeNode*, TreeNode*>> q; // Stores {node, parent}
        q.push({root, nullptr});

        int current_depth = 0;

        while (!q.empty()) {
            int level_size = q.size();
            long long current_level_total_sum = 0;

            // Map to store children grouped by their parent for the current level
            // Key: parent node, Value: vector of its children nodes
            std::map<TreeNode*, std::vector<TreeNode*>> parent_to_children_map;

            // Collect all nodes for the current level, calculate their sum,
            // and populate parent_to_children_map for the *next* level's nodes.
            std::vector<TreeNode*> nodes_in_current_level; // To process nodes at this level
            for (int i = 0; i < level_size; ++i) {
                TreeNode* node = q.front().first;
                TreeNode* parent = q.front().second;
                q.pop();

                nodes_in_current_level.push_back(node);
                current_level_total_sum += node->val;

                if (parent) { // Root has no parent
                    parent_to_children_map[parent].push_back(node);
                }
            }

            // Update node values for the current level
            // Root node (depth 0) has no cousins, its value is always 0.
            if (current_depth == 0) {
                root->val = 0;
            } else {
                // For all other nodes, update their values
                // The parent_to_children_map contains groups of siblings from the *previous* level.
                // We need to calculate sibling sums for nodes in `nodes_in_current_level`.
                // This means we need to iterate through parents of nodes in `nodes_in_current_level`.
                // The `parent_to_children_map` already has this information for the current level's nodes.
                for (auto const& [parent_node, children_list] : parent_to_children_map) {
                    long long sibling_sum = 0;
                    for (TreeNode* child : children_list) {
                        sibling_sum += child->val;
                    }

                    for (TreeNode* child : children_list) {
                        child->val = current_level_total_sum - sibling_sum;
                    }
                }
            }

            // Add children of the current level's nodes to the queue for the next iteration
            for (TreeNode* node : nodes_in_current_level) {
                if (node->left) {
                    q.push({node->left, node});
                }
                if (node->right) {
                    q.push({node->right, node});
                }
            }

            current_depth++;
        }

        return root;
    }
};