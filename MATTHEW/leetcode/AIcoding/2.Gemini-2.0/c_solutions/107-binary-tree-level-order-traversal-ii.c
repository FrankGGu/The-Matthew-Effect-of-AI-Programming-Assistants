#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int treeHeight(struct TreeNode* root) {
    if (!root) return 0;
    int leftHeight = treeHeight(root->left);
    int rightHeight = treeHeight(root->right);
    return (leftHeight > rightHeight ? leftHeight : rightHeight) + 1;
}

void levelOrder(struct TreeNode* root, int level, int** result, int* columnSizes, int* returnSize) {
    if (!root) return;
    result[level][columnSizes[level]++] = root->val;
    levelOrder(root->left, level - 1, result, columnSizes, returnSize);
    levelOrder(root->right, level - 1, result, columnSizes, returnSize);
}

int** levelOrderBottom(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    int height = treeHeight(root);
    *returnSize = height;

    if (height == 0) {
        *returnColumnSizes = NULL;
        return NULL;
    }

    int** result = (int**)malloc(height * sizeof(int*));
    *returnColumnSizes = (int*)malloc(height * sizeof(int));
    for (int i = 0; i < height; i++) {
        (*returnColumnSizes)[i] = 0;
        result[i] = (int*)malloc(1000 * sizeof(int)); 
    }

    levelOrder(root, height - 1, result, *returnColumnSizes, returnSize);

    int** reversedResult = (int**)malloc(height * sizeof(int*));
    int* reversedColumnSizes = (int*)malloc(height * sizeof(int));

    for(int i = 0; i < height; i++){
        reversedResult[i] = result[height - 1 - i];
        reversedColumnSizes[i] = (*returnColumnSizes)[height - 1 - i];
    }

    free(result);
    free(*returnColumnSizes);

    result = reversedResult;
    *returnColumnSizes = reversedColumnSizes;

    return result;
}