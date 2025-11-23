#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* constructFromPrePost(int* preorder, int preorderSize, int* postorder, int postorderSize) {
    if (preorderSize == 0) return NULL;

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = preorder[0];

    if (preorderSize == 1) {
        root->left = NULL;
        root->right = NULL;
        return root;
    }

    int leftVal = preorder[1];
    int leftSize = 0;
    for (int i = 0; i < postorderSize; i++) {
        if (postorder[i] == leftVal) {
            leftSize = i + 1;
            break;
        }
    }

    root->left = constructFromPrePost(preorder + 1, leftSize, postorder, leftSize);
    root->right = constructFromPrePost(preorder + 1 + leftSize, preorderSize - 1 - leftSize, postorder + leftSize, postorderSize - 1 - leftSize);

    return root;
}