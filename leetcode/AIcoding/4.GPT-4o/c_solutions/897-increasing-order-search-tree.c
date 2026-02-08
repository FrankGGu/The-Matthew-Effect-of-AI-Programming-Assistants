struct TreeNode* increasingBST(struct TreeNode* root) {
    struct TreeNode dummy;
    struct TreeNode* curr = &dummy;
    dummy.right = NULL;

    void inorder(struct TreeNode* node) {
        if (!node) return;
        inorder(node->left);
        curr->right = malloc(sizeof(struct TreeNode));
        curr->right->val = node->val;
        curr->right->left = NULL;
        curr = curr->right;
        inorder(node->right);
    }

    inorder(root);
    return dummy.right;
}