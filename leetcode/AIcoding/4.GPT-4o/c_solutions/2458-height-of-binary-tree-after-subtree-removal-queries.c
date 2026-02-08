int height(struct TreeNode* root) {
    if (!root) return 0;
    int leftHeight = height(root->left);
    int rightHeight = height(root->right);
    return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
}

void calculateHeight(struct TreeNode* root, int* heights, int* index) {
    if (!root) return;
    heights[root->val] = height(root);
    calculateHeight(root->left, heights, index);
    calculateHeight(root->right, heights, index);
}

int* treeQueries(struct TreeNode* root, int* queries, int queriesSize, int* returnSize) {
    int* heights = (int*)malloc(100001 * sizeof(int));
    memset(heights, 0, 100001 * sizeof(int));
    calculateHeight(root, heights, NULL);

    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        result[i] = heights[queries[i]] - 1;
    }

    free(heights);
    *returnSize = queriesSize;
    return result;
}