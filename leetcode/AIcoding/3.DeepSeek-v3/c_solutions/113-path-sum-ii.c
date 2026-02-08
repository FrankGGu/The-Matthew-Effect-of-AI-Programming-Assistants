#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void dfs(struct TreeNode* root, int targetSum, int* path, int depth, int** result, int* returnSize, int** returnColumnSizes) {
    if (root == NULL) return;

    path[depth] = root->val;

    if (root->left == NULL && root->right == NULL) {
        if (targetSum == root->val) {
            result[*returnSize] = (int*)malloc((depth + 1) * sizeof(int));
            for (int i = 0; i <= depth; i++) {
                result[*returnSize][i] = path[i];
            }
            (*returnColumnSizes)[*returnSize] = depth + 1;
            (*returnSize)++;
        }
        return;
    }

    if (root->left) {
        dfs(root->left, targetSum - root->val, path, depth + 1, result, returnSize, returnColumnSizes);
    }
    if (root->right) {
        dfs(root->right, targetSum - root->val, path, depth + 1, result, returnSize, returnColumnSizes);
    }
}

int** pathSum(struct TreeNode* root, int targetSum, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    if (root == NULL) return NULL;

    int** result = (int**)malloc(1000 * sizeof(int*));
    *returnColumnSizes = (int*)malloc(1000 * sizeof(int));
    int* path = (int*)malloc(1000 * sizeof(int));

    dfs(root, targetSum, path, 0, result, returnSize, returnColumnSizes);

    free(path);
    return result;
}