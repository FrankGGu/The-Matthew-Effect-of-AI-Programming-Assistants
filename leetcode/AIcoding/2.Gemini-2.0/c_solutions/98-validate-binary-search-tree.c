#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool isValidBSTHelper(struct TreeNode* root, long long min, long long max) {
    if (root == NULL) {
        return true;
    }

    if (root->val <= min || root->val >= max) {
        return false;
    }

    return isValidBSTHelper(root->left, min, root->val) && isValidBSTHelper(root->right, root->val, max);
}

bool isValidBST(struct TreeNode* root) {
    return isValidBSTHelper(root, LLONG_MIN, LLONG_MAX);
}