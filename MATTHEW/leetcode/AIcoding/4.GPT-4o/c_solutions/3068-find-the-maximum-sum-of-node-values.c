int maxSum = 0;

int findMaxSum(struct TreeNode* root) {
    if (!root) return 0;
    int left = findMaxSum(root->left);
    int right = findMaxSum(root->right);
    int currentSum = root->val + left + right;
    if (currentSum > maxSum) {
        maxSum = currentSum;
    }
    return currentSum;
}

int maxPathSum(struct TreeNode* root) {
    maxSum = INT_MIN;
    findMaxSum(root);
    return maxSum;
}