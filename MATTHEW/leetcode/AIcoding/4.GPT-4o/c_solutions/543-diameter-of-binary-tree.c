int diameter = 0;

int depth(struct TreeNode* node) {
    if (!node) return 0;
    int left = depth(node->left);
    int right = depth(node->right);
    diameter = diameter > left + right ? diameter : left + right;
    return 1 + (left > right ? left : right);
}

int diameterOfBinaryTree(struct TreeNode* root) {
    depth(root);
    return diameter;
}