#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode ** allPossibleFBT(int n, int* returnSize){
    if (n % 2 == 0) {
        *returnSize = 0;
        return NULL;
    }

    if (n == 1) {
        struct TreeNode **result = (struct TreeNode **)malloc(sizeof(struct TreeNode *));
        struct TreeNode *root = (struct TreeNode *)malloc(sizeof(struct TreeNode));
        root->val = 0;
        root->left = NULL;
        root->right = NULL;
        result[0] = root;
        *returnSize = 1;
        return result;
    }

    struct TreeNode **result = (struct TreeNode **)malloc(sizeof(struct TreeNode *) * 0);
    *returnSize = 0;

    for (int i = 1; i < n; i += 2) {
        int leftSize, rightSize;
        struct TreeNode **leftTrees = allPossibleFBT(i, &leftSize);
        struct TreeNode **rightTrees = allPossibleFBT(n - 1 - i, &rightSize);

        for (int j = 0; j < leftSize; j++) {
            for (int k = 0; k < rightSize; k++) {
                struct TreeNode *root = (struct TreeNode *)malloc(sizeof(struct TreeNode));
                root->val = 0;
                root->left = leftTrees[j];
                root->right = rightTrees[k];

                result = (struct TreeNode **)realloc(result, sizeof(struct TreeNode *) * (*returnSize + 1));
                result[*returnSize] = root;
                (*returnSize)++;
            }
        }

        if (leftTrees != NULL) {
            free(leftTrees);
        }
        if (rightTrees != NULL) {
            free(rightTrees);
        }
    }

    return result;
}