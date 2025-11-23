#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int **pathSum(struct TreeNode *root, int targetSum, int *returnSize, int **returnColumnSizes);

int **pathSum(struct TreeNode *root, int targetSum, int *returnSize, int **returnColumnSizes) {
    int **result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    if (!root) return result;

    int *currentPath = (int *)malloc(sizeof(int));
    int currentPathSize = 0;

    void dfs(struct TreeNode *node, int currentSum) {
        currentPath[currentPathSize++] = node->val;
        currentSum += node->val;

        if (!node->left && !node->right) {
            if (currentSum == targetSum) {
                *returnSize += 1;
                *returnColumnSizes = (int *)realloc(*returnColumnSizes, sizeof(int) * (*returnSize));
                (*returnColumnSizes)[*returnSize - 1] = currentPathSize;

                result = (int **)realloc(result, sizeof(int *) * (*returnSize));
                result[*returnSize - 1] = (int *)malloc(sizeof(int) * currentPathSize);
                for (int i = 0; i < currentPathSize; i++) {
                    result[*returnSize - 1][i] = currentPath[i];
                }
            }
        } else {
            if (node->left) dfs(node->left, currentSum);
            if (node->right) dfs(node->right, currentSum);
        }

        currentPathSize--;
    }

    dfs(root, 0);

    free(currentPath);
    return result;
}