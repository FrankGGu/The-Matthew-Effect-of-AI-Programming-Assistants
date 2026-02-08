#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int longestUnivaluePath(struct TreeNode* root) {
    int maxPath = 0;

    int dfs(struct TreeNode* node, int parentVal) {
        if (!node) return 0;
        int left = dfs(node->left, node->val);
        int right = dfs(node->right, node->val);
        maxPath = (left + right > maxPath) ? left + right : maxPath;
        return (node->val == parentVal) ? 1 + (left > right ? left : right) : 0;
    }

    dfs(root, -1);
    return maxPath;
}