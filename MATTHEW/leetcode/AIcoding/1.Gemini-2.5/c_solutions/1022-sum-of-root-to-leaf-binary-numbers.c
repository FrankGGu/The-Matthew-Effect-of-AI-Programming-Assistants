void dfs(struct TreeNode* node, int current_number, int* total_sum) {
    if (node == NULL) {
        return;
    }

    current_number = (current_number << 1) | node->val;

    if (node->left == NULL && node->right == NULL) {
        *total_sum += current_number;
        return;
    }

    dfs(node->left, current_number, total_sum);
    dfs(node->right, current_number, total_sum);
}

int sumRootToLeaf(struct TreeNode* root) {
    int total_sum = 0;
    dfs(root, 0, &total_sum);
    return total_sum;
}