int findSecondMinimumValue(struct TreeNode* root) {
    if (root == NULL) return -1;
    int min1 = root->val;
    int min2 = -1;

    void dfs(struct TreeNode* node) {
        if (node == NULL) return;
        if (node->val > min1) {
            if (min2 == -1) {
                min2 = node->val;
            } else {
                min2 = fmin(min2, node->val);
            }
        } else if (node->val == min1) {
            dfs(node->left);
            dfs(node->right);
        }
    }

    dfs(root);
    return min2;
}