struct TreeNode* lcaDeepestLeaves(struct TreeNode* root) {
    if (!root) return NULL;

    int depth = 0;
    struct TreeNode* lca = NULL;

    void dfs(struct TreeNode* node, int currentDepth) {
        if (!node) return;

        if (!node->left && !node->right) {
            if (currentDepth > depth) {
                depth = currentDepth;
                lca = node;
            } else if (currentDepth == depth) {
                lca = lca->val == node->val ? lca : NULL;
            }
        }

        dfs(node->left, currentDepth + 1);
        dfs(node->right, currentDepth + 1);
    }

    dfs(root, 0);
    return lca;
}