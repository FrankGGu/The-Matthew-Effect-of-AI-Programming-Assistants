#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int maxPathSum(struct TreeNode* root) {
    int maxSum = INT_MIN;

    int dfs(struct TreeNode* node) {
        if (!node) return 0;

        int left = fmax(0, dfs(node->left));
        int right = fmax(0, dfs(node->right));

        maxSum = fmax(maxSum, left + right + node->val);

        return node->val + fmax(left, right);
    }

    dfs(root);
    return maxSum;
}