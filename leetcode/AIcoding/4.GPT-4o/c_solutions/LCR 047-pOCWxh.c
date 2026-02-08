struct TreeNode* pruneTree(struct TreeNode* root) {
    if (!root) return NULL;
    root->left = pruneTree(root->left);
    root->right = pruneTree(root->right);
    if (!root->left && !root->right && root->val == 0) {
        free(root);
        return NULL;
    }
    return root;
}