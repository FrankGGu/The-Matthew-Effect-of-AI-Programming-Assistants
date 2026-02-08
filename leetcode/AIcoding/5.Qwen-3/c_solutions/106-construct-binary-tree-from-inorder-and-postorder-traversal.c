#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* buildTree(int* inorder, int inorderSize, int* postorder, int postorderSize) {
    if (inorderSize == 0 || postorderSize == 0) return NULL;

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = postorder[postorderSize - 1];

    int i;
    for (i = 0; i < inorderSize; i++) {
        if (inorder[i] == root->val) break;
    }

    root->left = buildTree(inorder, i, postorder, i);
    root->right = buildTree(inorder + i + 1, inorderSize - i - 1, postorder + i, inorderSize - i - 1);

    return root;
}