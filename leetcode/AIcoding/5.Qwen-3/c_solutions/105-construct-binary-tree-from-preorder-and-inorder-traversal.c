#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* buildTree(int* preorder, int preorderSize, int* inorder, int inorderSize) {
    if (preorderSize == 0 || inorderSize == 0) return NULL;

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = preorder[0];

    int i;
    for (i = 0; i < inorderSize; i++) {
        if (inorder[i] == root->val) break;
    }

    root->left = buildTree(preorder + 1, i, inorder, i);
    root->right = buildTree(preorder + i + 1, preorderSize - i - 1, inorder + i + 1, inorderSize - i - 1);

    return root;
}