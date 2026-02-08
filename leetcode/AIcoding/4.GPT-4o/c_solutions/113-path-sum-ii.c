void findPaths(struct TreeNode* root, int sum, int* returnSize, int** returnArray, int* path, int pathLen) {
    if (!root) return;

    path[pathLen++] = root->val;
    sum -= root->val;

    if (!root->left && !root->right && sum == 0) {
        returnArray[*returnSize] = (int*)malloc(pathLen * sizeof(int));
        memcpy(returnArray[*returnSize], path, pathLen * sizeof(int));
        (*returnSize)++;
    } else {
        findPaths(root->left, sum, returnSize, returnArray, path, pathLen);
        findPaths(root->right, sum, returnSize, returnArray, path, pathLen);
    }
}

int** pathSum(struct TreeNode* root, int sum, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    int** returnArray = (int**)malloc(1000 * sizeof(int*));
    *returnColumnSizes = (int*)malloc(1000 * sizeof(int));
    int path[1000];

    findPaths(root, sum, returnSize, returnArray, path, 0);

    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = sizeof(returnArray[i]) / sizeof(returnArray[i][0]);
    }

    return returnArray;
}