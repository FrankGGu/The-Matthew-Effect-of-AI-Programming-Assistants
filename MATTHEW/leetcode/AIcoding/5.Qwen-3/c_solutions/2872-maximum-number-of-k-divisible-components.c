#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int dfs(TreeNode* root, int k, int* count) {
    if (!root) return 0;
    int left = dfs(root->left, k, count);
    int right = dfs(root->right, k, count);
    int total = left + right + root->val;
    if (total % k == 0) {
        (*count)++;
    }
    return total;
}

int maxKDivisibleComponents(struct TreeNode* root, int k) {
    int count = 0;
    dfs(root, k, &count);
    return count;
}