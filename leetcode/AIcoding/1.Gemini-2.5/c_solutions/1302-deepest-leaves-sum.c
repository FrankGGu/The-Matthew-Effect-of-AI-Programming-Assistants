void dfs(struct TreeNode* node, int current_depth, int* max_depth, int* sum) {
    if (node == NULL) {
        return;
    }

    if (node->left == NULL && node->right == NULL) {
        if (current_depth > *max_depth) {
            *max_depth = current_depth;
            *sum = node->val;
        } else if (current_depth == *max_depth) {
            *sum += node->val;
        }
    }

    dfs(node->left, current_depth + 1, max_depth, sum);
    dfs(node->right, current_depth + 1, max_depth, sum);
}

int deepestLeavesSum(struct TreeNode* root) {
    int max_depth = -1;
    int sum = 0;

    dfs(root, 0, &max_depth, &sum);

    return sum;
}