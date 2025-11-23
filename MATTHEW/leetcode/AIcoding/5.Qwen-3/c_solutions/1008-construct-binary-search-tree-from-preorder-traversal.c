#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* newNode(int val) {
    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

struct TreeNode* bstFromPreorder(int* preorder, int preorderSize) {
    if (preorderSize == 0) return NULL;

    struct TreeNode* root = newNode(preorder[0]);
    for (int i = 1; i < preorderSize; i++) {
        struct TreeNode* node = root;
        while (1) {
            if (preorder[i] < node->val) {
                if (node->left == NULL) {
                    node->left = newNode(preorder[i]);
                    break;
                } else {
                    node = node->left;
                }
            } else {
                if (node->right == NULL) {
                    node->right = newNode(preorder[i]);
                    break;
                } else {
                    node = node->right;
                }
            }
        }
    }
    return root;
}