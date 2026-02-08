#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void recoverTree(struct TreeNode* root) {
    struct TreeNode *first = NULL, *second = NULL, *prev = NULL;

    void inorder(struct TreeNode* root) {
        if (!root) return;
        inorder(root->left);

        if (prev && root->val < prev->val) {
            if (!first) {
                first = prev;
                second = root;
            } else {
                second = root;
            }
        }
        prev = root;

        inorder(root->right);
    }

    inorder(root);

    int temp = first->val;
    first->val = second->val;
    second->val = temp;
}