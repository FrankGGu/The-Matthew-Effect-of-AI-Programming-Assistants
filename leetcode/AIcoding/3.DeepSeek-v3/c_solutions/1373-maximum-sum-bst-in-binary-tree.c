#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    int min;
    int max;
    int sum;
    int isBST;
} Result;

Result dfs(struct TreeNode* node, int* maxSum) {
    if (!node) {
        Result res = {INT_MAX, INT_MIN, 0, 1};
        return res;
    }

    Result left = dfs(node->left, maxSum);
    Result right = dfs(node->right, maxSum);

    Result res;
    res.isBST = 0;

    if (left.isBST && right.isBST && node->val > left.max && node->val < right.min) {
        res.isBST = 1;
        res.min = (left.min == INT_MAX) ? node->val : left.min;
        res.max = (right.max == INT_MIN) ? node->val : right.max;
        res.sum = left.sum + right.sum + node->val;
        if (res.sum > *maxSum) {
            *maxSum = res.sum;
        }
    } else {
        res.sum = 0;
    }

    return res;
}

int maxSumBST(struct TreeNode* root) {
    int maxSum = 0;
    dfs(root, &maxSum);
    return maxSum;
}