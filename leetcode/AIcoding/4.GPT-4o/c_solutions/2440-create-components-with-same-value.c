#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int totalSum;
int target;
int count = 0;

int dfs(struct TreeNode* node) {
    if (!node) return 0;
    int sum = node->val + dfs(node->left) + dfs(node->right);
    if (sum == target) count++;
    return sum;
}

int componentCount(struct TreeNode* root, int x) {
    totalSum = dfs(root);
    target = totalSum / x;
    if (totalSum % x != 0) return 0;
    count = 0;
    dfs(root);
    return count;
}