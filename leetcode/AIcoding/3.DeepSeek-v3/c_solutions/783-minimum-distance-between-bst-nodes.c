int minDiffInBST(struct TreeNode* root) {
    int prev = -1;
    int min_diff = INT_MAX;

    void inorder(struct TreeNode* node) {
        if (!node) return;
        inorder(node->left);
        if (prev != -1) {
            int diff = node->val - prev;
            if (diff < min_diff) min_diff = diff;
        }
        prev = node->val;
        inorder(node->right);
    }

    inorder(root);
    return min_diff;
}