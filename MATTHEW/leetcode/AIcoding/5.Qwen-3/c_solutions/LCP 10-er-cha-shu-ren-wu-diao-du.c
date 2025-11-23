#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode TreeNode;

int max(int a, int b) {
    return a > b ? a : b;
}

int dfs(TreeNode* node, int* result) {
    if (!node) return 0;
    int left = dfs(node->left, result);
    int right = dfs(node->right, result);
    int current = 1 + max(left, right);
    *result = max(*result, current);
    return current;
}

int height(struct TreeNode* root) {
    int result = 0;
    dfs(root, &result);
    return result;
}