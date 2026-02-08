#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int** pathSum(struct TreeNode* root, int targetSum, int* returnSize, int** returnColumnSizes);

int** pathSum(struct TreeNode* root, int targetSum, int* returnSize, int** returnColumnSizes) {
    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    if (!root) return result;

    int* path = (int*)malloc(sizeof(int));
    int pathLen = 0;

    void dfs(struct TreeNode* node, int currentSum) {
        path[pathLen++] = node->val;
        currentSum += node->val;

        if (!node->left && !node->right) {
            if (currentSum == targetSum) {
                int* newPath = (int*)malloc(pathLen * sizeof(int));
                for (int i = 0; i < pathLen; i++) {
                    newPath[i] = path[i];
                }
                (*returnSize)++;
                result = (int**)realloc(result, (*returnSize) * sizeof(int*));
                result[*returnSize - 1] = newPath;
                (*returnColumnSizes) = (int*)realloc(*returnColumnSizes, (*returnSize) * sizeof(int));
                (*returnColumnSizes)[*returnSize - 1] = pathLen;
            }
        } else {
            if (node->left) dfs(node->left, currentSum);
            if (node->right) dfs(node->right, currentSum);
        }

        pathLen--;
    }

    dfs(root, 0);
    free(path);
    return result;
}