int countNodes(struct TreeNode* root) {
    if (!root) return 0;

    struct TreeNode* left = root;
    struct TreeNode* right = root;
    int leftDepth = 0, rightDepth = 0;

    while (left) {
        leftDepth++;
        left = left->left;
    }

    while (right) {
        rightDepth++;
        right = right->right;
    }

    if (leftDepth == rightDepth) {
        return (1 << leftDepth) - 1;
    }

    return 1 + countNodes(root->left) + countNodes(root->right);
}