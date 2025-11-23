int countGoodNodes(struct TreeNode* root) {
    int count = 0;

    void dfs(struct TreeNode* node, int maxValue) {
        if (!node) return;
        if (node->val >= maxValue) {
            count++;
            maxValue = node->val;
        }
        dfs(node->left, maxValue);
        dfs(node->right, maxValue);
    }

    dfs(root, root->val);
    return count;
}