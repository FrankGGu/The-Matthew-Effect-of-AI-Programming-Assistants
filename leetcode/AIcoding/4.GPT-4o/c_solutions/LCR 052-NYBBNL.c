struct TreeNode* increasingBST(struct TreeNode* root) {
    struct TreeNode dummy = {0, NULL, NULL};
    struct TreeNode* current = &dummy;

    void inorder(struct TreeNode* node) {
        if (!node) return;
        inorder(node->left);
        current->right = malloc(sizeof(struct TreeNode));
        current->right->val = node->val;
        current->right->left = NULL;
        current = current->right;
        inorder(node->right);
    }

    inorder(root);
    return dummy.right;
}