#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int isValidBSTHelper(struct TreeNode* node, long min, long max) {
    if (node == NULL) return 1;

    if (node->val <= min || node->val >= max) return 0;

    return isValidBSTHelper(node->left, min, node->val) && 
           isValidBSTHelper(node->right, node->val, max);
}

int isValidBST(struct TreeNode* root) {
    return isValidBSTHelper(root, LONG_MIN, LONG_MAX);
}