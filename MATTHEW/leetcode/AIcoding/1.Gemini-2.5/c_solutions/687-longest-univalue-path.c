#include <stdlib.h> // Required for NULL

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

static int global_max_path;

static int max(int a, int b) {
    return a > b ? a : b;
}

static int dfs(struct TreeNode* node) {
    if (node == NULL) {
        return 0;
    }

    int left_path_from_child = dfs(node->left);
    int right_path_from_child = dfs(node->right);

    int current_left_len = 0;
    int current_right_len = 0;

    if (node->left != NULL && node->left->val == node->val) {
        current_left_len = left_path_from_child + 1;
    }
    if (node->right != NULL && node->right->val == node->val) {
        current_right_len = right_path_from_child + 1;
    }

    global_max_path = max(global_max_path, current_left_len + current_right_len);

    return max(current_left_len, current_right_len);
}

int longestUnivaluePath(struct TreeNode* root) {
    global_max_path = 0;
    dfs(root);
    return global_max_path;
}