#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* inorderSuccessor(struct TreeNode* root, struct TreeNode* p) {
    struct TreeNode* successor = NULL;

    while (root != NULL) {
        if (p->val >= root->val) {
            root = root->right;
        } else {
            successor = root;
            root = root->left;
        }
    }

    return successor;
}