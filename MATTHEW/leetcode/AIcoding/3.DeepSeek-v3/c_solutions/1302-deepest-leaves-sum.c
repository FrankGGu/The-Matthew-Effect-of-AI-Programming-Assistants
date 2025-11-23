#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int maxDepth(struct TreeNode* root) {
    if (root == NULL) return 0;
    int left = maxDepth(root->left);
    int right = maxDepth(root->right);
    return (left > right ? left : right) + 1;
}

void dfs(struct TreeNode* root, int depth, int targetDepth, int* sum) {
    if (root == NULL) return;
    if (depth == targetDepth) {
        *sum += root->val;
        return;
    }
    dfs(root->left, depth + 1, targetDepth, sum);
    dfs(root->right, depth + 1, targetDepth, sum);
}

int deepestLeavesSum(struct TreeNode* root) {
    int depth = maxDepth(root);
    int sum = 0;
    dfs(root, 1, depth, &sum);
    return sum;
}