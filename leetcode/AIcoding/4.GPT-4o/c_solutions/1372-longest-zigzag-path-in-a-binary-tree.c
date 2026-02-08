int longestZigZag(struct TreeNode* root) {
    int maxLength = 0;

    void dfs(struct TreeNode* node, int isLeft, int length) {
        if (!node) return;
        maxLength = fmax(maxLength, length);
        if (isLeft) {
            dfs(node->left, 0, length + 1);
            dfs(node->right, 1, 1);
        } else {
            dfs(node->left, 0, 1);
            dfs(node->right, 1, length + 1);
        }
    }

    dfs(root, 0, 0);
    dfs(root, 1, 0);
    return maxLength;
}