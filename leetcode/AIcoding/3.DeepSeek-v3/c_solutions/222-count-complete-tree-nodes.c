int countNodes(struct TreeNode* root) {
    if (root == NULL) return 0;

    int left_height = 0, right_height = 0;
    struct TreeNode* left = root;
    struct TreeNode* right = root;

    while (left != NULL) {
        left_height++;
        left = left->left;
    }

    while (right != NULL) {
        right_height++;
        right = right->right;
    }

    if (left_height == right_height) {
        return (1 << left_height) - 1;
    }

    return 1 + countNodes(root->left) + countNodes(root->right);
}