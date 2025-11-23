class Solution {
public:
    int goodNodes(TreeNode* root) {
        return dfs(root, root->val);
    }

    int dfs(TreeNode* node, int maxVal) {
        if (!node) return 0;
        int count = (node->val >= maxVal) ? 1 : 0;
        maxVal = max(maxVal, node->val);
        count += dfs(node->left, maxVal);
        count += dfs(node->right, maxVal);
        return count;
    }
};