#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* bstFromPreorder(int* preorder, int preorderSize){
    int i = 0;
    return buildTree(preorder, &i, INT_MAX, preorderSize);
}

struct TreeNode* buildTree(int* preorder, int* i, int bound, int preorderSize) {
    if (*i == preorderSize || preorder[*i] > bound) {
        return NULL;
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = preorder[*i];
    *i = *i + 1;
    root->left = buildTree(preorder, i, root->val, preorderSize);
    root->right = buildTree(preorder, i, bound, preorderSize);
    return root;
}