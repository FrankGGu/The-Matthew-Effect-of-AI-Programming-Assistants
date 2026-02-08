int maxAncestorDiff(struct TreeNode* root) {
    if (!root) return 0;
    int maxDiff = 0;

    void helper(struct TreeNode* node, int minVal, int maxVal) {
        if (!node) return;
        int currentDiff = maxVal - minVal;
        if (currentDiff > maxDiff) maxDiff = currentDiff;
        minVal = fmin(minVal, node->val);
        maxVal = fmax(maxVal, node->val);
        helper(node->left, minVal, maxVal);
        helper(node->right, minVal, maxVal);
    }

    helper(root, root->val, root->val);
    return maxDiff;
}