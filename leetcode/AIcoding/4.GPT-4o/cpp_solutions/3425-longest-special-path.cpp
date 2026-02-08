class Solution {
public:
    int longestSpecialPath(TreeNode* root) {
        return dfs(root, nullptr);
    }

    int dfs(TreeNode* node, TreeNode* parent) {
        if (!node) return 0;

        int left = dfs(node->left, node);
        int right = dfs(node->right, node);

        if (parent && node->val != parent->val) {
            return max(left, right) + 1;
        }
        return max(left, right);
    }
};