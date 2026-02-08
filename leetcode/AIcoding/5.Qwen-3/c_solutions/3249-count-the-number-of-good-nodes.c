#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int countGoodNodes(struct TreeNode* root) {
    int count = 0;

    void dfs(struct TreeNode* node, int maxSoFar) {
        if (!node) return;
        if (node->val >= maxSoFar) {
            count++;
            maxSoFar = node->val;
        }
        dfs(node->left, maxSoFar);
        dfs(node->right, maxSoFar);
    }

    dfs(root, root->val);
    return count;
}