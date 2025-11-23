bool isColorable(struct TreeNode* root, int color) {
    if (!root) return true;

    if (root->val != color) return false;

    return isColorable(root->left, 1 - color) && isColorable(root->right, 1 - color);
}

bool isBicolorable(struct TreeNode* root) {
    return isColorable(root, 0);
}