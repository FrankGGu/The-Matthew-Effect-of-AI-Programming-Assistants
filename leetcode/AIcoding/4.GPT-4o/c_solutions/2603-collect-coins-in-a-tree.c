#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int dfs(TreeNode* node, int* coins, int* moves) {
    if (!node) return 0;
    int left = dfs(node->left, coins, moves);
    int right = dfs(node->right, coins, moves);
    *moves += abs(left) + abs(right);
    return node->val + left + right - 1;
}

int collectTheCoins(TreeNode* root, int* coins, int coinsSize) {
    int moves = 0;
    dfs(root, coins, &moves);
    return moves;
}