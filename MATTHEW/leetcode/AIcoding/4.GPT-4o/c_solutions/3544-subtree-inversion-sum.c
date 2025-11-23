int invertTree(struct TreeNode* root) {
    if (!root) return 0;

    int leftSum = invertTree(root->left);
    int rightSum = invertTree(root->right);

    int temp = root->left;
    root->left = root->right;
    root->right = temp;

    return root->val + leftSum + rightSum;
}