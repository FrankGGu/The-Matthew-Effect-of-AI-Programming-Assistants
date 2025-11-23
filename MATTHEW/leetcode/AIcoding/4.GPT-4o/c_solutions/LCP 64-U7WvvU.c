int dfs(struct TreeNode* root, int* count) {
    if (!root) return 0;
    int left = dfs(root->left, count);
    int right = dfs(root->right, count);

    if (left == 1 || right == 1) {
        (*count)++;
        return 2; // This node is illuminated
    }

    if (left == 0 && right == 0) {
        return 0; // This node is dark
    }

    return 1; // This node has illumination from its children
}

int minCameraCover(struct TreeNode* root) {
    int count = 0;
    if (dfs(root, &count) == 0) {
        count++;
    }
    return count;
}