#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void pathSumHelper(struct TreeNode* root, int targetSum, int* path, int pathLen, int** result, int* returnSize, int** returnColumnSizes) {
    if (!root) return;

    path[pathLen++] = root->val;

    if (!root->left && !root->right && root->val == targetSum) {
        (*returnColumnSizes)[*returnSize] = pathLen;
        result[*returnSize] = (int*)malloc(sizeof(int) * pathLen);
        for (int i = 0; i < pathLen; i++) {
            result[*returnSize][i] = path[i];
        }
        (*returnSize)++;
        return;
    }

    pathSumHelper(root->left, targetSum - root->val, path, pathLen, result, returnSize, returnColumnSizes);
    pathSumHelper(root->right, targetSum - root->val, path, pathLen, result, returnSize, returnColumnSizes);
}

int** pathSum(struct TreeNode* root, int targetSum, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * 1000);
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(sizeof(int) * 1000);
    int path[1000];
    pathSumHelper(root, targetSum, path, 0, result, returnSize, returnColumnSizes);
    return result;
}