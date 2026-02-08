int dfs(struct TreeNode* root, int* tilt) {
    if (root == NULL) return 0;

    int leftSum = dfs(root->left, tilt);
    int rightSum = dfs(root->right, tilt);

    *tilt += abs(leftSum - rightSum);

    return leftSum + rightSum + root->val;
}

int findTilt(struct TreeNode* root) {
    int tilt = 0;
    dfs(root, &tilt);
    return tilt;
}