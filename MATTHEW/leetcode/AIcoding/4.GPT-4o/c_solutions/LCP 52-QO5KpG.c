void dfs(struct TreeNode* node, int* color, int* count, int k, int* result) {
    if (!node) return;
    if (color[node->val] == 0) {
        color[node->val] = 1;
        count[0]++;
        if (count[0] == k) {
            result[0] = node->val;
        }
    }
    dfs(node->left, color, count, k, result);
    dfs(node->right, color, count, k, result);
}

int kthSmallest(struct TreeNode* root, int k) {
    int color[100001] = {0};
    int count[1] = {0};
    int result[1] = {0};
    dfs(root, color, count, k, result);
    return result[0];
}