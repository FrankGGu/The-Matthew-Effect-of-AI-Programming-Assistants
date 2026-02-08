#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int dfs(struct TreeNode* node, int* count) {
    if (!node) return 0;
    int left = dfs(node->left, count);
    int right = dfs(node->right, count);
    if (left == 1) (*count)++;
    if (right == 1) (*count)++;
    return node->val == 1 ? 1 : (left == 1 || right == 1);
}

int maximizeTheNumberOfTargetNodes(struct TreeNode* root) {
    int count = 0;
    dfs(root, &count);
    return count;
}