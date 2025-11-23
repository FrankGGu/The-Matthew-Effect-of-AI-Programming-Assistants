bool isSymmetric(struct TreeNode* left, struct TreeNode* right) {
    if (!left && !right) return true;
    if (!left || !right) return false;
    return (left->val == right->val) && isSymmetric(left->left, right->right) && isSymmetric(left->right, right->left);
}

bool isSymmetricTree(struct TreeNode* root) {
    return isSymmetric(root, root);
}