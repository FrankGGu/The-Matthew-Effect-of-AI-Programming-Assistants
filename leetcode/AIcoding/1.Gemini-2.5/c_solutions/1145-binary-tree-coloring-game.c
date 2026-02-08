int g_left_x_size;
int g_right_x_size;
int g_target_x_val;

int dfs_calculate_sizes(struct TreeNode* node) {
    if (!node) {
        return 0;
    }

    int left_subtree_size = dfs_calculate_sizes(node->left);
    int right_subtree_size = dfs_calculate_sizes(node->right);

    if (node->val == g_target_x_val) {
        g_left_x_size = left_subtree_size;
        g_right_x_size = right_subtree_size;
    }

    return 1 + left_subtree_size + right_subtree_size;
}

bool btreeGameWinningStrategy(struct TreeNode* root, int n, int x) {
    g_target_x_val = x;
    g_left_x_size = 0;
    g_right_x_size = 0;

    dfs_calculate_sizes(root);

    if (g_left_x_size > n / 2) {
        return true;
    }

    if (g_right_x_size > n / 2) {
        return true;
    }

    int parent_side_size = n - (1 + g_left_x_size + g_right_x_size);
    if (parent_side_size > n / 2) {
        return true;
    }

    return false;
}