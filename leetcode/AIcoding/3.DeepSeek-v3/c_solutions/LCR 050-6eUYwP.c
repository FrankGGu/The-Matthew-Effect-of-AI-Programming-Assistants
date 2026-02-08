int pathSum(struct TreeNode* root, int targetSum) {
    if (root == NULL) return 0;

    int count = 0;

    void dfs(struct TreeNode* node, long long currentSum) {
        if (node == NULL) return;

        currentSum += node->val;
        if (currentSum == targetSum) {
            count++;
        }

        dfs(node->left, currentSum);
        dfs(node->right, currentSum);
    }

    void traverse(struct TreeNode* node) {
        if (node == NULL) return;

        dfs(node, 0);
        traverse(node->left);
        traverse(node->right);
    }

    traverse(root);
    return count;
}