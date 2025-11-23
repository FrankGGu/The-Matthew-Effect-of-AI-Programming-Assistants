#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* buildTree(int* preorder, int preorderSize, int* postorder, int postorderSize) {
    if (preorderSize == 0 || postorderSize == 0) return NULL;
    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = preorder[0];
    if (preorderSize == 1) {
        root->left = NULL;
        root->right = NULL;
        return root;
    }
    int leftSubtreeSize = 0;
    for (int i = 0; i < postorderSize - 1; i++) {
        if (postorder[i] == preorder[1]) {
            leftSubtreeSize = i + 1;
            break;
        }
    }
    root->left = buildTree(preorder + 1, leftSubtreeSize, postorder, leftSubtreeSize);
    root->right = buildTree(preorder + 1 + leftSubtreeSize, preorderSize - 1 - leftSubtreeSize, postorder + leftSubtreeSize, preorderSize - 1 - leftSubtreeSize);
    return root;
}