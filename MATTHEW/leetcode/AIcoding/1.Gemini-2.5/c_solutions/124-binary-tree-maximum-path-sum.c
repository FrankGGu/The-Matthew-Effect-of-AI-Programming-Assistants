#include <stdlib.h> // For NULL
#include <limits.h> // For INT_MIN

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

static int max(int a, int b) {
    return a > b ? a : b;
}

static int dfs(struct TreeNode* node, int* max_overall_sum_ptr) {
    if (node == NULL) {
        return 0;
    }

    // Recursively get the maximum path sum from left and right children.
    // We take max(0, ...) because a negative path sum from a child would be worse than not taking that path.
    int left_gain = max(0, dfs(node->left, max_overall_sum_ptr));
    int right_gain = max(0, dfs(node->right, max_overall_sum_ptr));

    // Calculate the path sum if this node is the "peak" of the path.
    // This path includes the current node's value and potentially both left and right branches.
    // This value is a candidate for the overall maximum path sum, but cannot be extended upwards to the parent.
    int current_path_sum_through_node = node->val + left_gain + right_gain;

    // Update the overall maximum path sum found so far
    *max_overall_sum_ptr = max(*max_overall_sum_ptr, current_path_sum_through_node);

    // Return the maximum path sum that can be extended upwards to the parent.
    // This path can only include one of the children (or neither) to maintain a single path upwards.
    return node->val + max(left_gain, right_gain);
}

int maxPathSum(struct TreeNode* root) {
    // Initialize max_overall_sum with the smallest possible integer value,
    // as node values can be negative.
    int max_overall_sum = INT_MIN;
    dfs(root, &max_overall_sum);
    return max_overall_sum;
}