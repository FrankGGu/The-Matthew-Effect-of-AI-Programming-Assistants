struct TreeNode* sufficientSubset(struct TreeNode* root, int limit) {
    if (root == NULL) {
        return NULL;
    }

    limit -= root->val;

    if (root->left == NULL && root->right == NULL) {
        if (limit > 0) {
            return NULL;
        } else {
            return root;
        }
    }

    root->left = sufficientSubset(root->left, limit);
    root->right = sufficientSubset(root->right, limit);

    if (root->left == NULL && root->right == NULL) {
        return NULL;
    }

    return root;
}