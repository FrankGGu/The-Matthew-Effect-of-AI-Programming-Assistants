class Solution {
public:
    int goodNodes(TreeNode* root) {
        return dfs(root, root->val);
    }

    int dfs(TreeNode* node, int maxSoFar) {
        if (!node) return 0;
        int goodCount = (node->val >= maxSoFar) ? 1 : 0;
        maxSoFar = max(maxSoFar, node->val);
        goodCount += dfs(node->left, maxSoFar);
        goodCount += dfs(node->right, maxSoFar);
        return goodCount;
    }
};