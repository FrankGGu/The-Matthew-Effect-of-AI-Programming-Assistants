#include <vector>
#include <algorithm>
#include <map>

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
    std::map<int, int> node_depth;
    std::map<int, int> node_height;
    std::map<int, int> dp_val; // Stores the max depth reachable in the tree if current node's subtree is removed

    // DFS1: Calculate depth and height for each node
    // Returns the height of the subtree rooted at 'node'
    int dfs1_height_depth(TreeNode* node, int d) {
        if (!node) {
            return -1; // Height of a null node is -1
        }
        node_depth[node->val] = d;
        int left_h = dfs1_height_depth(node->left, d + 1);
        int right_h = dfs1_height_depth(node->right, d + 1);
        node_height[node->val] = std::max(left_h, right_h) + 1;
        return node_height[node->val];
    }

    // DFS2: Calculate the maximum depth reachable from the root, excluding the current node's subtree.
    // This value is the height of the tree after removing the current node's subtree.
    // max_depth_from_parent_and_siblings: Represents the maximum depth of any node in the tree
    //                                     that is NOT in the current node's subtree,
    //                                     and comes from paths through the parent or parent's other children.
    void dfs2_max_reach(TreeNode* node, int max_depth_from_parent_and_siblings) {
        if (!node) {
            return;
        }

        // The answer for removing 'node's subtree is 'max_depth_from_parent_and_siblings'.
        // This value represents the maximum depth of any node in the tree,
        // considering only paths that do not pass through 'node's subtree.
        dp_val[node->val] = max_depth_from_parent_and_siblings;

        // Calculate the 'max_depth_from_parent_and_siblings' value for the left child.
        // It's the maximum of:
        // 1. The value passed down from the current node's parent (max_depth_from_parent_and_siblings).
        // 2. The maximum depth reachable through the current node's right subtree (if it exists).
        int left_child_max_reach = max_depth_from_parent_and_siblings;
        if (node->right) {
            // max depth of a leaf in node->right's subtree = node_depth[node->right->val] + node_height[node->right->val]
            left_child_max_reach = std::max(left_child_max_reach, node_depth[node->right->val] + node_height[node->right->val]);
        }

        // Calculate the 'max_depth_from_parent_and_siblings' value for the right child.
        // It's the maximum of:
        // 1. The value passed down from the current node's parent (max_depth_from_parent_and_siblings).
        // 2. The maximum depth reachable through the current node's left subtree (if it exists).
        int right_child_max_reach = max_depth_from_parent_and_siblings;
        if (node->left) {
            // max depth of a leaf in node->left's subtree = node_depth[node->left->val] + node_height[node->left->val]
            right_child_max_reach = std::max(right_child_max_reach, node_depth[node->left->val] + node_height[node->left->val]);
        }

        // Recursively call for children
        dfs2_max_reach(node->left, left_child_max_reach);
        dfs2_max_reach(node->right, right_child_max_reach);
    }

    std::vector<int> treeQueries(TreeNode* root, std::vector<int>& queries) {
        // Step 1: Populate node_depth and node_height maps for all nodes
        // Start DFS from root at depth 0
        dfs1_height_depth(root, 0);

        // Step 2: Populate dp_val map using the second DFS
        // For the root, if its subtree is removed, the tree becomes empty.
        // The height of an empty tree is -1. So, initial max_depth_from_parent_and_siblings for root is -1.
        dfs2_max_reach(root, -1);

        // Step 3: Collect results for queries
        std::vector<int> results;
        results.reserve(queries.size()); // Pre-allocate memory for efficiency
        for (int query_val : queries) {
            results.push_back(dp_val[query_val]);
        }

        return results;
    }
};