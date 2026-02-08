bool isCousins(struct TreeNode* root, int x, int y) {
    if (!root) return false;
    struct TreeNode* parentX = NULL;
    struct TreeNode* parentY = NULL;
    int depthX = -1, depthY = -1;

    void dfs(struct TreeNode* node, int depth, struct TreeNode* parent) {
        if (!node) return;
        if (node->val == x) {
            parentX = parent;
            depthX = depth;
        } else if (node->val == y) {
            parentY = parent;
            depthY = depth;
        }
        dfs(node->left, depth + 1, node);
        dfs(node->right, depth + 1, node);
    }

    dfs(root, 0, NULL);

    return (depthX == depthY) && (parentX != parentY);
}