bool hasPathSum(struct TreeNode* root, int targetSum) {
    if (!root) return targetSum == 0;
    targetSum -= root->val;
    if (!root->left && !root->right) return targetSum == 0;
    return hasPathSum(root->left, targetSum) || hasPathSum(root->right, targetSum);
}