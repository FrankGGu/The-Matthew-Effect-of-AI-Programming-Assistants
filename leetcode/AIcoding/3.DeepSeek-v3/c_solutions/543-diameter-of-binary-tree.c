int max(int a, int b) {
    return a > b ? a : b;
}

int dfs(struct TreeNode* root, int* diameter) {
    if (root == NULL) return 0;
    int left = dfs(root->left, diameter);
    int right = dfs(root->right, diameter);
    *diameter = max(*diameter, left + right);
    return max(left, right) + 1;
}

int diameterOfBinaryTree(struct TreeNode* root) {
    int diameter = 0;
    dfs(root, &diameter);
    return diameter;
}