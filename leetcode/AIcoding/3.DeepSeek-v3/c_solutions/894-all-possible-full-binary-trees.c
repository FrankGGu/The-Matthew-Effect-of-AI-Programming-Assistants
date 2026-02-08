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

    if (n == 1) {
        struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        root->val = 0;
        root->left = root->right = NULL;
        *returnSize = 1;
        struct TreeNode** result = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
        result[0] = root;
        return result;
    }

    struct TreeNode** result = NULL;
    *returnSize = 0;

    for (int i = 1; i < n; i += 2) {
        int leftSize, rightSize;
        struct TreeNode** leftTrees = allPossibleFBT(i, &leftSize);
        struct TreeNode** rightTrees = allPossibleFBT(n - i - 1, &rightSize);

        for (int j = 0; j < leftSize; j++) {
            for (int k = 0; k < rightSize; k++) {
                struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
                root->val = 0;
                root->left = leftTrees[j];
                root->right = rightTrees[k];

                (*returnSize)++;
                result = (struct TreeNode**)realloc(result, (*returnSize) * sizeof(struct TreeNode*));
                result[(*returnSize) - 1] = root;
            }
        }

        free(leftTrees);
        free(rightTrees);
    }

    return result;
}