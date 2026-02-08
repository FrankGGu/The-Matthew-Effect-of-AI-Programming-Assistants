#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int isBST;
    int minVal;
    int maxVal;
    int sum;
} BSTInfo;

int maxSumBST(TreeNode* root) {
    int maxSum = 0;

    BSTInfo* dfs(TreeNode* node) {
        if (!node) {
            BSTInfo* info = (BSTInfo*)malloc(sizeof(BSTInfo));
            info->isBST = 1;
            info->minVal = INT_MAX;
            info->maxVal = INT_MIN;
            info->sum = 0;
            return info;
        }

        BSTInfo* left = dfs(node->left);
        BSTInfo* right = dfs(node->right);

        BSTInfo* current = (BSTInfo*)malloc(sizeof(BSTInfo));
        current->isBST = left->isBST && right->isBST && (node->val > left->maxVal) && (node->val < right->minVal);
        current->minVal = fmin(node->val, fmin(left->minVal, right->minVal));
        current->maxVal = fmax(node->val, fmax(left->maxVal, right->maxVal));
        current->sum = node->val + left->sum + right->sum;

        if (current->isBST) {
            maxSum = fmax(maxSum, current->sum);
        }

        free(left);
        free(right);
        return current;
    }

    dfs(root);
    return maxSum;
}