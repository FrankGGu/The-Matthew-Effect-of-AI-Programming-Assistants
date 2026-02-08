#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int minDiffInBST(struct TreeNode* root) {
    int minDiff = 100000;
    struct TreeNode* prev = NULL;

    void inorder(struct TreeNode* node) {
        if (node == NULL) return;
        inorder(node->left);
        if (prev != NULL) {
            minDiff = (minDiff < (node->val - prev->val)) ? minDiff : (node->val - prev->val);
        }
        prev = node;
        inorder(node->right);
    }

    inorder(root);
    return minDiff;
}