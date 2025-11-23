void backtrack(struct TreeNode* root, int targetSum, int* path, int* returnSize, int** result, int* pathSize) {
    if (!root) return;

    path[(*pathSize)++] = root->val;

    if (!root->left && !root->right && root->val == targetSum) {
        result[*returnSize] = (int*)malloc((*pathSize) * sizeof(int));
        memcpy(result[*returnSize], path, (*pathSize) * sizeof(int));
        (*returnSize)++;
    } else {
        backtrack(root->left, targetSum - root->val, path, returnSize, result, pathSize);
        backtrack(root->right, targetSum - root->val, path, returnSize, result, pathSize);
    }

    (*pathSize)--;
}

int** pathSum(struct TreeNode* root, int targetSum, int** returnColumnSizes, int* returnSize) {
    int** result = (int**)malloc(1000 * sizeof(int*));
    int* path = (int*)malloc(1000 * sizeof(int));
    *returnSize = 0;

    backtrack(root, targetSum, path, returnSize, result, &(int){0});

    *returnColumnSizes = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = sizeof(result[i]) / sizeof(int);
    }

    free(path);

    return result;
}