#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int minDepth(struct TreeNode* root) {
    if (root == NULL) return 0;

    if (root->left == NULL && root->right == NULL) return 1;

    int left_depth = INT_MAX;
    if (root->left != NULL) {
        left_depth = minDepth(root->left);
    }

    int right_depth = INT_MAX;
    if (root->right != NULL) {
        right_depth = minDepth(root->right);
    }

    return (left_depth < right_depth ? left_depth : right_depth) + 1;
}