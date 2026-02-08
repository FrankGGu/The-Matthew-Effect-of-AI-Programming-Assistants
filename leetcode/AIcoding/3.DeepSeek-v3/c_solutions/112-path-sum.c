#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool hasPathSum(struct TreeNode* root, int targetSum) {
    if (root == NULL) {
        return false;
    }

    if (root->left == NULL && root->right == NULL) {
        return targetSum == root->val;
    }

    int newSum = targetSum - root->val;
    return hasPathSum(root->left, newSum) || hasPathSum(root->right, newSum);
}