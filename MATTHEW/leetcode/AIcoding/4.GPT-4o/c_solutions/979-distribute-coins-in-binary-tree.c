int moves = 0;

int dfs(struct TreeNode* root) {
    if (!root) return 0;
    int left = dfs(root->left);
    int right = dfs(root->right);
    moves += abs(left) + abs(right);
    return root->val + left + right - 1;
}

int distributeCoins(struct TreeNode* root) {
    moves = 0;
    dfs(root);
    return moves;
}