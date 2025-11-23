#include <stdlib.h>
#include <limits.h>

static int preorder_idx;

struct TreeNode* build(int* preorder, int preorderSize, int bound) {
    if (preorder_idx == preorderSize || preorder[preorder_idx] > bound) {
        return NULL;
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = preorder[preorder_idx];
    preorder_idx++;

    root->left = build(preorder, preorderSize, root->val);
    root->right = build(preorder, preorderSize, bound);

    return root;
}

struct TreeNode* bstFromPreorder(int* preorder, int preorderSize) {
    preorder_idx = 0;
    return build(preorder, preorderSize, INT_MAX);
}