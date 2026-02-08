int maxPathSumHelper(struct TreeNode* root, int* maxSum) {
    if (!root) return 0;

    int left = fmax(0, maxPathSumHelper(root->left, maxSum));
    int right = fmax(0, maxPathSumHelper(root->right, maxSum));

    *maxSum = fmax(*maxSum, root->val + left + right);

    return root->val + fmax(left, right);
}

int maxPathSum(struct TreeNode* root) {
    int maxSum = INT_MIN;
    maxPathSumHelper(root, &maxSum);
    return maxSum;
}