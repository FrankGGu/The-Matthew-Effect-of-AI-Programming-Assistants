int minCost(struct TreeNode* root) {
    if (!root) return 0;

    int leftCost = minCost(root->left);
    int rightCost = minCost(root->right);

    return leftCost + rightCost + (root->left ? root->left->val : 0) + (root->right ? root->right->val : 0);
}