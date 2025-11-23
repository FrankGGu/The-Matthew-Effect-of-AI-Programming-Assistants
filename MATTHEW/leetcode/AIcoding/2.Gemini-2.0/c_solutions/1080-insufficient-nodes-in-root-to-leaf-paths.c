#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* sufficientSubset(struct TreeNode* root, int limit) {
    int helper(struct TreeNode* node, int currentSum, int limit) {
        if (!node) return 0;

        if (!node->left && !node->right) {
            return currentSum + node->val >= limit;
        }

        int leftSufficient = helper(node->left, currentSum + node->val, limit);
        int rightSufficient = helper(node->right, currentSum + node->val, limit);

        if (!leftSufficient) {
            free(node->left);
            node->left = NULL;
        }
        if (!rightSufficient) {
            free(node->right);
            node->right = NULL;
        }

        return leftSufficient || rightSufficient;
    }

    if (!root) return NULL;

    if (!helper(root, 0, limit)) {
        free(root);
        return NULL;
    }

    return root;
}