long long totalSum = 0;
long long maxProduct = 0;

void calculateTotalSum(struct TreeNode* root) {
    if (!root) return;
    totalSum += root->val;
    calculateTotalSum(root->left);
    calculateTotalSum(root->right);
}

long long calculateSubtreeSum(struct TreeNode* root) {
    if (!root) return 0;
    long long leftSum = calculateSubtreeSum(root->left);
    long long rightSum = calculateSubtreeSum(root->right);
    long long subtreeSum = leftSum + rightSum + root->val;
    maxProduct = fmax(maxProduct, subtreeSum * (totalSum - subtreeSum));
    return subtreeSum;
}

int maxProduct(struct TreeNode* root) {
    calculateTotalSum(root);
    calculateSubtreeSum(root);
    return (int)(maxProduct % 1000000007);
}