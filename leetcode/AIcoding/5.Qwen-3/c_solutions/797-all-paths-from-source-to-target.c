#include <stdio.h>
#include <stdlib.h>

int** allPathsSourceTarget(struct TreeNode* root, int* returnSize, int** returnColumnSizes);

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void dfs(struct TreeNode* node, int* path, int pathLen, int*** result, int* returnSize, int** returnColumnSizes) {
    if (!node) return;
    path[pathLen++] = node->val;
    if (!node->left && !node->right) {
        (*result) = (int**)realloc(*result, (*returnSize + 1) * sizeof(int*));
        (*result)[*returnSize] = (int*)malloc(pathLen * sizeof(int));
        for (int i = 0; i < pathLen; i++) {
            (*result)[*returnSize][i] = path[i];
        }
        (*returnColumnSizes)[*returnSize] = pathLen;
        (*returnSize)++;
    } else {
        dfs(node->left, path, pathLen, result, returnSize, returnColumnSizes);
        dfs(node->right, path, pathLen, result, returnSize, returnColumnSizes);
    }
}

int** allPathsSourceTarget(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    int** result = NULL;
    int* path = (int*)malloc(1000 * sizeof(int));
    dfs(root, path, 0, &result, returnSize, returnColumnSizes);
    free(path);
    return result;
}