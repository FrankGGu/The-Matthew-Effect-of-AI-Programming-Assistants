bool isBalanced(struct TreeNode* root) {
    if (root == NULL) return true;

    int height(struct TreeNode* node) {
        if (node == NULL) return 0;
        int leftHeight = height(node->left);
        if (leftHeight == -1) return -1;
        int rightHeight = height(node->right);
        if (rightHeight == -1) return -1;
        if (abs(leftHeight - rightHeight) > 1) return -1;
        return fmax(leftHeight, rightHeight) + 1;
    }

    return height(root) != -1;
}