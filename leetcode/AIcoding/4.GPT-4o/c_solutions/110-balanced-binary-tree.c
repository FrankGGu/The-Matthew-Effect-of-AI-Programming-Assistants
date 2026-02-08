bool isBalanced(struct TreeNode* root) {
    if (root == NULL) return true;

    int height(struct TreeNode* node) {
        if (node == NULL) return 0;
        int leftHeight = height(node->left);
        int rightHeight = height(node->right);
        if (leftHeight == -1 || rightHeight == -1 || abs(leftHeight - rightHeight) > 1) {
            return -1;
        }
        return fmax(leftHeight, rightHeight) + 1;
    }

    return height(root) != -1;
}