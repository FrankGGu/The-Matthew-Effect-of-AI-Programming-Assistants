int* robTree(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return (int*)malloc(2 * sizeof(int));
    }

    int* left = robTree(root->left, returnSize);
    int* right = robTree(root->right, returnSize);

    int* res = (int*)malloc(2 * sizeof(int));
    res[0] = root->val + left[1] + right[1];
    res[1] = fmax(left[0], left[1]) + fmax(right[0], right[1]);

    free(left);
    free(right);

    *returnSize = 2;
    return res;
}

int rob(struct TreeNode* root) {
    int returnSize;
    int* res = robTree(root, &returnSize);
    return fmax(res[0], res[1]);
}