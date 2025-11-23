int dfs(struct TreeNode* root, int* cameras) {
    if (!root) return 1;

    int left = dfs(root->left, cameras);
    int right = dfs(root->right, cameras);

    if (left == 0 || right == 0) {
        (*cameras)++;
        return 2;
    }

    return (left == 2 || right == 2) ? 1 : 0;
}

int minCameraCover(struct TreeNode* root) {
    int cameras = 0;
    if (dfs(root, &cameras) == 0) {
        cameras++;
    }
    return cameras;
}