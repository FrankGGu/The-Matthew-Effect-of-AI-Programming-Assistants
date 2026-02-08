bool hasPathSum(struct TreeNode* root, int targetSum) {
    if (root == NULL) {
        return false;
    }

    if (root->left == NULL && root->right == NULL) {
        return root->val == targetSum;
    }

    int remainingSum = targetSum - root->val;

    return hasPathSum(root->left, remainingSum) || hasPathSum(root->right, remainingSum);
}