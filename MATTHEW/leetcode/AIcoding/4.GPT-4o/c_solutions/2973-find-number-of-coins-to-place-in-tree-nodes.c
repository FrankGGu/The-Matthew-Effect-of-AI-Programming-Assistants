int dfs(struct TreeNode* root, int* moves) {
    if (!root) return 0;
    int left = dfs(root->left, moves);
    int right = dfs(root->right, moves);
    *moves += abs(left) + abs(right) + (root->val - 1);
    return left + right + root->val - 1;
}

int distributeCoins(struct TreeNode* root) {
    int moves = 0;
    dfs(root, &moves);
    return moves;
}