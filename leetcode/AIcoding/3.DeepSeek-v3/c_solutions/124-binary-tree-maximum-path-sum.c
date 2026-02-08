#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int maxSum;

int maxGain(struct TreeNode* node) {
    if (node == NULL) return 0;

    int leftGain = maxGain(node->left);
    int rightGain = maxGain(node->right);

    if (leftGain < 0) leftGain = 0;
    if (rightGain < 0) rightGain = 0;

    int currentPath = node->val + leftGain + rightGain;
    if (currentPath > maxSum) maxSum = currentPath;

    return node->val + (leftGain > rightGain ? leftGain : rightGain);
}

int maxPathSum(struct TreeNode* root) {
    maxSum = INT_MIN;
    maxGain(root);
    return maxSum;
}