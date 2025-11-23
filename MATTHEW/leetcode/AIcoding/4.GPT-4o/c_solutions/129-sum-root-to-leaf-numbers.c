int sumNumbers(struct TreeNode* root) {
    return sumHelper(root, 0);
}

int sumHelper(struct TreeNode* node, int currentSum) {
    if (!node) return 0;
    currentSum = currentSum * 10 + node->val;
    if (!node->left && !node->right) return currentSum;
    return sumHelper(node->left, currentSum) + sumHelper(node->right, currentSum);
}