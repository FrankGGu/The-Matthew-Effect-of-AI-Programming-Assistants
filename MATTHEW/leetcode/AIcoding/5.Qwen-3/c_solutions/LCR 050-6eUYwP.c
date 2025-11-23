#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int pathSum(struct TreeNode* root, int targetSum) {
    if (!root) return 0;

    int count = 0;

    void dfs(struct TreeNode* node, long long currentSum) {
        if (!node) return;
        currentSum += node->val;
        if (currentSum == targetSum) count++;
        dfs(node->left, currentSum);
        dfs(node->right, currentSum);
    }

    dfs(root, 0);

    return count + pathSum(root->left, targetSum) + pathSum(root->right, targetSum);
}