#include <stdbool.h>
#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool isValidBSTHelper(struct TreeNode* node, long minVal, long maxVal) {
    if (node == NULL) {
        return true;
    }

    if (node->val <= minVal || node->val >= maxVal) {
        return false;
    }

    return isValidBSTHelper(node->left, minVal, node->val) &&
           isValidBSTHelper(node->right, node->val, maxVal);
}

bool isValidBST(struct TreeNode* root) {
    return isValidBSTHelper(root, LONG_MIN, LONG_MAX);
}