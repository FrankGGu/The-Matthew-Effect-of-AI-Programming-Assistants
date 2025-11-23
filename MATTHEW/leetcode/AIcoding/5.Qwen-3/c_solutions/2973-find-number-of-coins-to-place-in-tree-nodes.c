#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int dfs(TreeNode* node, int* result) {
    if (!node) return 0;
    int left = dfs(node->left, result);
    int right = dfs(node->right, result);
    int total = left + right + node->val;
    if (total > 0) (*result)++;
    return total;
}

int countCoins(TreeNode* root) {
    int result = 0;
    dfs(root, &result);
    return result;
}