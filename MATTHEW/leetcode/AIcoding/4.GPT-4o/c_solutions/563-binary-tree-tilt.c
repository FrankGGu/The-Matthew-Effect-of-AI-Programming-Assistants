int tilt = 0;

int dfs(struct TreeNode* root) {
    if (!root) return 0;
    int leftSum = dfs(root->left);
    int rightSum = dfs(root->right);
    tilt += abs(leftSum - rightSum);
    return leftSum + rightSum + root->val;
}

int findTilt(struct TreeNode* root) {
    tilt = 0;
    dfs(root);
    return tilt;
}