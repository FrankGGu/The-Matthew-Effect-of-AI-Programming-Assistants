#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int minDiffInBST(struct TreeNode* root) {
    int min_diff = INT_MAX;
    int prev = -1;

    void inorder(struct TreeNode* node) {
        if (node == NULL) {
            return;
        }

        inorder(node->left);

        if (prev != -1) {
            int diff = abs(node->val - prev);
            if (diff < min_diff) {
                min_diff = diff;
            }
        }
        prev = node->val;

        inorder(node->right);
    }

    inorder(root);
    return min_diff;
}