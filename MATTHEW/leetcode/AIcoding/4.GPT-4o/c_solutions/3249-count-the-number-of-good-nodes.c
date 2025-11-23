int goodNodesHelper(struct TreeNode* node, int maxVal) {
    if (!node) return 0;

    int good = node->val >= maxVal ? 1 : 0;
    maxVal = node->val > maxVal ? node->val : maxVal;

    return good + goodNodesHelper(node->left, maxVal) + goodNodesHelper(node->right, maxVal);
}

int goodNodes(struct TreeNode* root) {
    return goodNodesHelper(root, root->val);
}