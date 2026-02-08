#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* buildTree(int* inorder, int inorderSize, int* postorder, int postorderSize) {
    if (inorderSize == 0 || postorderSize == 0) {
        return NULL;
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = postorder[postorderSize - 1];
    root->left = NULL;
    root->right = NULL;

    int rootIndex = 0;
    for (int i = 0; i < inorderSize; i++) {
        if (inorder[i] == root->val) {
            rootIndex = i;
            break;
        }
    }

    root->left = buildTree(inorder, rootIndex, postorder, rootIndex);
    root->right = buildTree(inorder + rootIndex + 1, inorderSize - rootIndex - 1, postorder + rootIndex, postorderSize - rootIndex - 1);

    return root;
}