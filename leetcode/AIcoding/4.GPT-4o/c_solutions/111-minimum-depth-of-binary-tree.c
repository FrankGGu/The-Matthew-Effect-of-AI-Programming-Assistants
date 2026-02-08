int minDepth(struct TreeNode* root) {
    if (root == NULL) return 0;
    if (root->left == NULL && root->right == NULL) return 1;

    int leftDepth = root->left ? minDepth(root->left) : INT_MAX;
    int rightDepth = root->right ? minDepth(root->right) : INT_MAX;

    return 1 + (leftDepth < rightDepth ? leftDepth : rightDepth);
}