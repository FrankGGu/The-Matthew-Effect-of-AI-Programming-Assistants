class Solution {
public:
    int goodNodes(TreeNode* root) {
        return dfs(root, INT_MIN);
    }

    int dfs(TreeNode* node, int max_val) {
        if (!node) return 0;
        int res = node->val >= max_val ? 1 : 0;
        max_val = max(max_val, node->val);
        res += dfs(node->left, max_val);
        res += dfs(node->right, max_val);
        return res;
    }
};