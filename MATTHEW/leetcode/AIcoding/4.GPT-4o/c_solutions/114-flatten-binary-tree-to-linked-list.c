void flatten(struct TreeNode* root) {
    struct TreeNode* current = root;

    while (current != NULL) {
        if (current->left != NULL) {
            struct TreeNode* rightmost = current->left;
            while (rightmost->right != NULL) {
                rightmost = rightmost->right;
            }
            rightmost->right = current->right;
            current->right = current->left;
            current->left = NULL;
        }
        current = current->right;
    }
}