#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int maxPathSumHelper(struct TreeNode* root, int* maxSum) {
    if (!root) return 0;

    int leftSum = maxPathSumHelper(root->left, maxSum);
    int rightSum = maxPathSumHelper(root->right, maxSum);

    int maxBranch = (leftSum > 0 ? leftSum : 0) + (rightSum > 0 ? rightSum : 0) + root->val;
    int maxSingle = (leftSum > rightSum ? leftSum : rightSum) > 0 ? (leftSum > rightSum ? leftSum : rightSum) + root->val : root->val;

    if (maxBranch > *maxSum) *maxSum = maxBranch;
    if (maxSingle > *maxSum) *maxSum = maxSingle;
    if (root->val > *maxSum) *maxSum = root->val;

    return (leftSum > rightSum ? leftSum : rightSum) > 0 ? (leftSum > rightSum ? leftSum : rightSum) + root->val : root->val;
}

int maxPathSum(struct TreeNode* root) {
    int maxSum = INT_MIN;
    maxPathSumHelper(root, &maxSum);
    return maxSum;
}