#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int maxZigZag(struct TreeNode* root) {
    int max_len = 0;

    void dfs(struct TreeNode* node, int dir, int len) {
        if (!node) {
            return;
        }

        if (len > max_len) {
            max_len = len;
        }

        if (dir == 0) { // from left
            dfs(node->right, 1, len + 1);
            dfs(node->left, 0, 1);
        } else { // from right
            dfs(node->left, 0, len + 1);
            dfs(node->right, 1, 1);
        }
    }

    if (root) {
        dfs(root->left, 0, 1);
        dfs(root->right, 1, 1);
    }

    return max_len;
}