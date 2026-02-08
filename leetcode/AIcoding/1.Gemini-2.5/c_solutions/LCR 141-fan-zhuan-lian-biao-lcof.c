#include <limits.h> // Required for INT_MIN

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int global_max_path_sum;

int max(int a, int b) {
    return a > b ? a : b;
}

int maxPathSumHelper(struct TreeNode* node) {
    if (node == NULL) {
        return 0;
    }

    // Recursively get the maximum path sum from the left and right children.
    // We take max(0, ...) because a negative path sum from a child subtree
    // would reduce the total sum, so we'd rather not include it.
    int left_gain = max(0, maxPathSumHelper(node->left));
    int right_gain = max(0, maxPathSumHelper(node->right));

    // Calculate the path sum if this node is the "peak" of a path
    // (i.e., the path goes from left child, through this node, to the right child).
    int current_path_sum_through_node = node->val + left_gain + right_gain;

    // Update the global maximum path sum found so far.
    // This accounts for paths that don't necessarily go through the root of the entire tree.
    global_max_path_sum = max(global_max_path_sum, current_path_sum_through_node);

    // Return the maximum path sum *starting from* this node and extending downwards
    // (either through the left child or the right child, or just ending at this node).
    // This value is used by the parent node to calculate its own path sum.
    return node->val + max(left_gain, right_gain);
}

int maxPathSum(struct TreeNode* root) {
    // Initialize global_max_path_sum to the smallest possible integer value.
    // This ensures that any valid path sum, even a single negative node value,
    // will correctly update the maximum.
    global_max_path_sum = INT_MIN;

    // Start the recursive helper function from the root.
    // The return value of the helper function is not directly used here,
    // as the overall maximum is stored in global_max_path_sum.
    maxPathSumHelper(root);

    // Return the final maximum path sum found.
    return global_max_path_sum;
}