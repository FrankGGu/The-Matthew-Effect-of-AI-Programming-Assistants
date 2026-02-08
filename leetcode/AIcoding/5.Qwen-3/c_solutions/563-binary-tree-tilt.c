#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int findTilt(struct TreeNode* root) {
    int tilt = 0;
    int* ptr = &tilt;
    int sum = 0;
    int* sumPtr = &sum;

    void helper(struct TreeNode* node) {
        if (!node) return;
        helper(node->left);
        helper(node->right);
        int leftSum = 0, rightSum = 0;
        if (node->left) leftSum = node->left->val;
        if (node->right) rightSum = node->right->val;
        *ptr += abs(leftSum - rightSum);
        node->val += leftSum + rightSum;
    }

    helper(root);
    return tilt;
}