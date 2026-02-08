#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode** allPossibleFBT(int n, int* returnSize) {
    if (n % 2 == 0) {
        *returnSize = 0;
        return NULL;
    }

    struct TreeNode** result = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
    *returnSize = 0;

    if (n == 1) {
        struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        node->val = 0;
        node->left = NULL;
        node->right = NULL;
        result[0] = node;
        *returnSize = 1;
        return result;
    }

    for (int i = 1; i < n; i += 2) {
        int leftSize = i;
        int rightSize = n - i - 1;

        struct TreeNode** leftTrees = allPossibleFBT(leftSize, NULL);
        struct TreeNode** rightTrees = allPossibleFBT(rightSize, NULL);

        for (int l = 0; leftTrees != NULL && leftTrees[l] != NULL; l++) {
            for (int r = 0; rightTrees != NULL && rightTrees[r] != NULL; r++) {
                struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
                node->val = 0;
                node->left = leftTrees[l];
                node->right = rightTrees[r];

                (*returnSize)++;
                result = (struct TreeNode**)realloc(result, (*returnSize) * sizeof(struct TreeNode*));
                result[*returnSize - 1] = node;
            }
        }

        free(leftTrees);
        free(rightTrees);
    }

    return result;
}