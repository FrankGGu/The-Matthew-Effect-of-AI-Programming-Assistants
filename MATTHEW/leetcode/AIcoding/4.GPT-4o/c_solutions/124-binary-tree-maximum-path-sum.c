int maxPathSumHelper(struct TreeNode* root, int* maxSum) {
    if (!root) return 0;

    int left = maxPathSumHelper(root->left, maxSum);
    int right = maxPathSumHelper(root->right, maxSum);

    int maxSingle = fmax(fmax(left + root->val, right + root->val), root->val);
    int maxTop = fmax(maxSingle, left + right + root->val);

    *maxSum = fmax(*maxSum, maxTop);

    return maxSingle;
}

int maxPathSum(struct TreeNode* root) {
    int maxSum = INT_MIN;
    maxPathSumHelper(root, &maxSum);
    return maxSum;
}