#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int sumNumbers(struct TreeNode* root) {
    int sum = 0;
    void dfs(struct TreeNode* node, int current) {
        if (!node) return;
        current = current * 10 + node->val;
        if (!node->left && !node->right) {
            sum += current;
            return;
        }
        dfs(node->left, current);
        dfs(node->right, current);
    }
    dfs(root, 0);
    return sum;
}