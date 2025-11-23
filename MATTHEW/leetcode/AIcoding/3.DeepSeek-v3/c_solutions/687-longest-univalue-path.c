int maxLen;

int dfs(struct TreeNode* root) {
    if (root == NULL) return 0;

    int left = dfs(root->left);
    int right = dfs(root->right);

    int leftPath = 0, rightPath = 0;

    if (root->left != NULL && root->left->val == root->val) {
        leftPath = left + 1;
    }
    if (root->right != NULL && root->right->val == root->val) {
        rightPath = right + 1;
    }

    maxLen = fmax(maxLen, leftPath + rightPath);

    return fmax(leftPath, rightPath);
}

int longestUnivaluePath(struct TreeNode* root) {
    maxLen = 0;
    dfs(root);
    return maxLen;
}