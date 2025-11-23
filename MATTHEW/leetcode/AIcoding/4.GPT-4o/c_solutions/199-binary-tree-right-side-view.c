void rightSideViewHelper(struct TreeNode* root, int level, int* maxLevel, int** result, int* returnSize) {
    if (root == NULL) return;
    if (level > *maxLevel) {
        result[0][*returnSize] = root->val;
        (*returnSize)++;
        *maxLevel = level;
    }
    rightSideViewHelper(root->right, level + 1, maxLevel, result, returnSize);
    rightSideViewHelper(root->left, level + 1, maxLevel, result, returnSize);
}

int* rightSideView(struct TreeNode* root, int* returnSize) {
    int* result = (int*)malloc(100 * sizeof(int));
    *returnSize = 0;
    int maxLevel = -1;
    int* res[1] = {result};
    rightSideViewHelper(root, 0, &maxLevel, res, returnSize);
    return result;
}