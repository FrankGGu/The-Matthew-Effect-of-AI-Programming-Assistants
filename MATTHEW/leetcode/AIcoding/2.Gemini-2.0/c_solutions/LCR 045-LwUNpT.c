#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int findBottomLeftValue(struct TreeNode* root) {
    int bottomLeftValue = 0;
    int maxDepth = -1;

    void dfs(struct TreeNode* node, int depth) {
        if (!node) {
            return;
        }

        if (depth > maxDepth) {
            maxDepth = depth;
            bottomLeftValue = node->val;
        }

        dfs(node->left, depth + 1);
        dfs(node->right, depth + 1);
    }

    dfs(root, 0);
    return bottomLeftValue;
}