void recoverTree(struct TreeNode* root) {
    struct TreeNode* first = NULL;
    struct TreeNode* second = NULL;
    struct TreeNode* prev = NULL;

    void inorder(struct TreeNode* node) {
        if (!node) return;
        inorder(node->left);
        if (prev && prev->val > node->val) {
            if (!first) first = prev;
            second = node;
        }
        prev = node;
        inorder(node->right);
    }

    inorder(root);
    if (first && second) {
        int temp = first->val;
        first->val = second->val;
        second->val = temp;
    }
}