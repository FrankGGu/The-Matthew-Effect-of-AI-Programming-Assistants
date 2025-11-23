int result;

int dfs(struct TreeNode* node) {
    if (node == NULL) return 2;

    int left = dfs(node->left);
    int right = dfs(node->right);

    if (left == 0 || right == 0) {
        result++;
        return 1;
    }

    if (left == 1 || right == 1) {
        return 2;
    }

    return 0;
}

int minCameraCover(struct TreeNode* root) {
    result = 0;
    if (dfs(root) == 0) {
        result++;
    }
    return result;
}