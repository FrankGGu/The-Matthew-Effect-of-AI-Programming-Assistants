#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int isBSTUtil(TreeNode* node, long min, long max) {
    if (node == NULL) return 1;
    if (node->val <= min || node->val >= max) return 0;
    return isBSTUtil(node->left, min, node->val) && isBSTUtil(node->right, node->val, max);
}

int isValidBST(TreeNode* root) {
    return isBSTUtil(root, LONG_MIN, LONG_MAX);
}