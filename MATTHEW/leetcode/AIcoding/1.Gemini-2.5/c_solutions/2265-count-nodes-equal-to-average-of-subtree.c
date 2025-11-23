struct SubtreeInfo {
    int sum;
    int count;
};

struct SubtreeInfo dfs(struct TreeNode* node, int* count_equal_avg) {
    if (node == NULL) {
        struct SubtreeInfo info = {0, 0};
        return info;
    }

    struct SubtreeInfo left_info = dfs(node->left, count_equal_avg);
    struct SubtreeInfo right_info = dfs(node->right, count_equal_avg);

    int current_sum = node->val + left_info.sum + right_info.sum;
    int current_count = 1 + left_info.count + right_info.count;

    if (node->val == (current_sum / current_count)) {
        (*count_equal_avg)++;
    }

    struct SubtreeInfo current_info = {current_sum, current_count};
    return current_info;
}

int averageOfSubtree(struct TreeNode* root) {
    int count_equal_avg = 0;
    dfs(root, &count_equal_avg);
    return count_equal_avg;
}