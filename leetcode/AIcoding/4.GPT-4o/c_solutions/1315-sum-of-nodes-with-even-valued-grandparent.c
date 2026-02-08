int sumEvenGrandparent(struct TreeNode* root) {
    int sum = 0;

    void dfs(struct TreeNode* node, int parent, int grandparent) {
        if (!node) return;
        if (grandparent % 2 == 0) {
            sum += node->val;
        }
        dfs(node->left, node->val, parent);
        dfs(node->right, node->val, parent);
    }

    dfs(root, 1, 1);
    return sum;
}