int minDiffInBST(struct TreeNode* root) {
    int minDiff = INT_MAX;
    int prev = -1;

    void inorder(struct TreeNode* node) {
        if (!node) return;
        inorder(node->left);
        if (prev != -1) {
            minDiff = fmin(minDiff, node->val - prev);
        }
        prev = node->val;
        inorder(node->right);
    }

    inorder(root);
    return minDiff;
}