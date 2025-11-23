#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int distributeCoins(struct TreeNode* root) {
    int moves = 0;

    int dfs(struct TreeNode* node) {
        if (!node) return 0;
        int left = dfs(node->left);
        int right = dfs(node->right);
        moves += abs(left) + abs(right);
        return node->val + left + right - 1;
    }

    dfs(root);
    return moves;
}