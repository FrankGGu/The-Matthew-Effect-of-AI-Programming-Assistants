#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int max(int a, int b) {
    return a > b ? a : b;
}

int helper(struct TreeNode* root, int* maxSum) {
    if (root == NULL) return 0;

    int left = max(helper(root->left, maxSum), 0);
    int right = max(helper(root->right, maxSum), 0);

    int currentPath = root->val + left + right;
    *maxSum = max(*maxSum, currentPath);

    return root->val + max(left, right);
}

int maxPathSum(struct TreeNode* root) {
    int maxSum = INT_MIN;
    helper(root, &maxSum);
    return maxSum;
}