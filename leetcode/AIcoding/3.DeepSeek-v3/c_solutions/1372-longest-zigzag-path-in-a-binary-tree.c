#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int max(int a, int b) {
    return a > b ? a : b;
}

void dfs(struct TreeNode* node, int left, int right, int* max_len) {
    if (!node) return;

    *max_len = max(*max_len, max(left, right));

    dfs(node->left, right + 1, 0, max_len);
    dfs(node->right, 0, left + 1, max_len);
}

int longestZigZag(struct TreeNode* root) {
    int max_len = 0;
    dfs(root, 0, 0, &max_len);
    return max_len;
}