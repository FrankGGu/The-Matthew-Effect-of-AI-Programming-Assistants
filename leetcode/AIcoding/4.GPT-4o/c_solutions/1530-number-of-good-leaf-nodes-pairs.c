int countPairs(struct TreeNode* root, int distance) {
    int count = 0;

    void dfs(struct TreeNode* node, int depth[], int* count) {
        if (!node) return;
        if (!node->left && !node->right) {
            depth[0]++;
            return;
        }
        int leftDepth[11] = {0}, rightDepth[11] = {0};
        dfs(node->left, leftDepth, count);
        dfs(node->right, rightDepth, count);
        for (int i = 0; i < leftDepth[0]; ++i) {
            for (int j = 0; j < rightDepth[0]; ++j) {
                if (i + j + 2 <= distance) {
                    (*count)++;
                }
            }
        }
        for (int i = 1; i <= leftDepth[0]; ++i) {
            depth[i] += leftDepth[i - 1];
        }
        for (int i = 1; i <= rightDepth[0]; ++i) {
            depth[i] += rightDepth[i - 1];
        }
        depth[0] = leftDepth[0] + rightDepth[0];
    }

    int depth[11] = {0};
    dfs(root, depth, &count);
    return count;
}