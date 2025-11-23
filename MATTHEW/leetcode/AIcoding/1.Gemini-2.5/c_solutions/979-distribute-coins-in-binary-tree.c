#include <stdlib.h> // For abs

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int dfs(struct TreeNode* node, int* total_moves) {
    if (node == NULL) {
        return 0;
    }

    int left_balance = dfs(node->left, total_moves);
    int right_balance = dfs(node->right, total_moves);

    *total_moves += abs(left_balance);
    *total_moves += abs(right_balance);

    return node->val + left_balance + right_balance - 1;
}

int distributeCoins(struct TreeNode* root) {
    int total_moves = 0;
    dfs(root, &total_moves);
    return total_moves;
}