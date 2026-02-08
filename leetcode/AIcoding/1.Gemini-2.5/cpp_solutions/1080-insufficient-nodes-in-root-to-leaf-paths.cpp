class Solution {
public:
    TreeNode* sufficientSubset(TreeNode* root, int limit) {
        return dfs(root, 0, limit);
    }

private:
    TreeNode* dfs(TreeNode* node, int current_path_sum, int limit) {
        if (node == nullptr) {
            return nullptr;
        }

        int new_path_sum = current_path_sum + node->val;

        // If it's a leaf node
        if (node->left == nullptr && node->right == nullptr) {
            if (new_path_sum < limit) {
                return nullptr;
            } else {
                return node;
            }
        }

        node->left = dfs(node->left, new_path_sum, limit);
        node->right = dfs(node->right, new_path_sum, limit);

        // After processing children, if both children are now null,
        // this node effectively becomes a leaf.
        // We then check if the path sum to this "new" leaf is less than limit.
        if (node->left == nullptr && node->right == nullptr) {
            if (new_path_sum < limit) {
                return nullptr;
            } else {
                return node;
            }
        }

        // If the node still has at least one sufficient child, it remains in the tree.
        return node;
    }
};