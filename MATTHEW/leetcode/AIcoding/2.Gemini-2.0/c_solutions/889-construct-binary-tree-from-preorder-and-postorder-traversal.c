#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* constructFromPrePost(int* preorder, int preorderSize, int* postorder, int postorderSize) {
    if (preorderSize == 0) {
        return NULL;
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = preorder[0];
    root->left = NULL;
    root->right = NULL;

    if (preorderSize == 1) {
        return root;
    }

    int leftSize = 0;
    for (int i = 0; i < postorderSize; i++) {
        if (postorder[i] == preorder[1]) {
            leftSize = i + 1;
            break;
        }
    }

    root->left = constructFromPrePost(preorder + 1, leftSize, postorder, leftSize);
    root->right = constructFromPrePost(preorder + leftSize + 1, preorderSize - leftSize - 1, postorder + leftSize, postorderSize - leftSize - 1);

    return root;
}