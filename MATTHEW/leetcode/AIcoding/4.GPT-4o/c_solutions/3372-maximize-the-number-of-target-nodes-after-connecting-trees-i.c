#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int maxTargetNodes(struct TreeNode* root, int limit) {
    if (!root) return 0;

    int left = maxTargetNodes(root->left, limit - root->val);
    int right = maxTargetNodes(root->right, limit - root->val);

    if (!root->left && !root->right) {
        return (limit <= root->val) ? 1 : 0;
    }

    return left + right;
}

int connectTrees(struct TreeNode* root, int limit) {
    return maxTargetNodes(root, limit);
}