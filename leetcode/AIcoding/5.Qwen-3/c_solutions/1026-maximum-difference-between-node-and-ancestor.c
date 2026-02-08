#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int maxDiff(struct TreeNode* root, int currentMax) {
    if (!root) return 0;
    int diff = currentMax - root->val;
    int leftDiff = maxDiff(root->left, (currentMax > root->val) ? currentMax : root->val);
    int rightDiff = maxDiff(root->right, (currentMax > root->val) ? currentMax : root->val);
    return (diff > leftDiff) ? (diff > rightDiff ? diff : rightDiff) : (leftDiff > rightDiff ? leftDiff : rightDiff);
}

int maxAncestorDiff(struct TreeNode* root) {
    if (!root) return 0;
    return maxDiff(root, root->val);
}