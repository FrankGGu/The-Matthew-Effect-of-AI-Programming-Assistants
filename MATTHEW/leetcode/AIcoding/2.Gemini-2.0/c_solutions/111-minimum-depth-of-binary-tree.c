#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int minDepth(struct TreeNode* root){
    if (root == NULL) {
        return 0;
    }

    if (root->left == NULL && root->right == NULL) {
        return 1;
    }

    int leftDepth = INT_MAX, rightDepth = INT_MAX;

    if (root->left != NULL) {
        leftDepth = minDepth(root->left);
    }

    if (root->right != NULL) {
        rightDepth = minDepth(root->right);
    }

    return 1 + (leftDepth < rightDepth ? leftDepth : rightDepth);
}