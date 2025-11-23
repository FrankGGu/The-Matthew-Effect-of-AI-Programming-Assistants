#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int maxSumUtil(TreeNode* root, int* maxSum) {
    if (!root) return 0;

    int left = maxSumUtil(root->left, maxSum);
    int right = maxSumUtil(root->right, maxSum);

    int current = root->val + left + right;
    if (current > *maxSum) {
        *maxSum = current;
    }

    return current;
}

int maxSumBST(TreeNode* root) {
    int maxSum = 0;
    maxSumUtil(root, &maxSum);
    return maxSum;
}