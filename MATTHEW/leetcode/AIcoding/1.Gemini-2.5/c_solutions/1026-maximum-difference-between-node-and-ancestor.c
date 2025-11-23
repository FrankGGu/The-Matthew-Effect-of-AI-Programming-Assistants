#include <stdlib.h> // For abs

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

static int max(int a, int b) {
    return (a > b) ? a : b;
}

static int min(int a, int b) {
    return (a < b) ? a : b;
}

static int dfs(struct TreeNode* node, int current_min, int current_max) {
    if (!node) {
        return 0;
    }

    int diff1 = abs(node->val - current_min);
    int diff2 = abs(node->val - current_max);
    int max_diff_at_node = max(diff1, diff2);

    int next_min = min(current_min, node->val);
    int next_max = max(current_max, node->val);

    int left_subtree_diff = dfs(node->left, next_min, next_max);
    int right_subtree_diff = dfs(node->right, next_min, next_max);

    return max(max_diff_at_node, max(left_subtree_diff, right_subtree_diff));
}

int maxAncestorDiff(struct TreeNode* root) {
    if (!root) {
        return 0;
    }
    return dfs(root, root->val, root->val);
}