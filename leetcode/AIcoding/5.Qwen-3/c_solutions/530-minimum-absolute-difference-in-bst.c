#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void inorderTraversal(struct TreeNode* root, int* prev, int* minDiff) {
    if (root == NULL) return;
    inorderTraversal(root->left, prev, minDiff);
    if (*prev != INT_MIN) {
        *minDiff = fmin(*minDiff, root->val - *prev);
    }
    *prev = root->val;
    inorderTraversal(root->right, prev, minDiff);
}

int getMinimumDifference(struct TreeNode* root) {
    int prev = INT_MIN;
    int minDiff = INT_MAX;
    inorderTraversal(root, &prev, &minDiff);
    return minDiff;
}