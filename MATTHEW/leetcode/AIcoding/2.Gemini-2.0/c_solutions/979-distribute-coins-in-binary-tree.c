#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int distributeCoinsHelper(struct TreeNode* root, int* moves) {
    if (!root) return 0;

    int leftDeficit = distributeCoinsHelper(root->left, moves);
    int rightDeficit = distributeCoinsHelper(root->right, moves);

    *moves += abs(leftDeficit) + abs(rightDeficit);

    return root->val + leftDeficit + rightDeficit - 1;
}

int distributeCoins(struct TreeNode* root) {
    int moves = 0;
    distributeCoinsHelper(root, &moves);
    return moves;
}