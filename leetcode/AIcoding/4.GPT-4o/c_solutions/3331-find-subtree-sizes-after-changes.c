int* findSubtreeSizes(struct TreeNode* root, int* returnSize) {
    int* sizes = malloc(10000 * sizeof(int));
    *returnSize = 0;

    void dfs(struct TreeNode* node) {
        if (!node) return;
        int leftSize = dfs(node->left);
        int rightSize = dfs(node->right);
        int size = leftSize + rightSize + 1;
        sizes[(*returnSize)++] = size;
        return size;
    }

    dfs(root);
    return sizes;
}