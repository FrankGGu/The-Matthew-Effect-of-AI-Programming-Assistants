class Solution {
public:
    int pseudoPalindromicPaths(TreeNode* root) {
        return dfs(root, 0);
    }

    int dfs(TreeNode* node, int count) {
        if (!node) return 0;
        count ^= (1 << node->val);
        if (!node->left && !node->right) {
            return (count & (count - 1)) == 0 ? 1 : 0;
        }
        return dfs(node->left, count) + dfs(node->right, count);
    }
};