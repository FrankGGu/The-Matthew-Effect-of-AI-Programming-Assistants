#include <stddef.h> // Required for NULL

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

long long totalSum_global;
long long maxProductValue_global;

long long dfs_calculate_subtree_sum_and_update_max_product(struct TreeNode* node) {
    if (node == NULL) {
        return 0;
    }

    // Recursively calculate the sum of the left and right subtrees
    long long current_subtree_sum = node->val +
                                    dfs_calculate_subtree_sum_and_update_max_product(node->left) +
                                    dfs_calculate_subtree_sum_and_update_max_product(node->right);

    // After calculating the sum of the current subtree, consider it as one part
    // if we split the edge connecting this subtree to its parent.
    // The other part of the tree will have a sum of (totalSum_global - current_subtree_sum).
    long long current_product = current_subtree_sum * (totalSum_global - current_subtree_sum);

    // Update the global maximum product if the current product is greater
    if (current_product > maxProductValue_global) {
        maxProductValue_global = current_product;
    }

    return current_subtree_sum;
}

long long calculate_total_sum_initial_pass(struct TreeNode* node) {
    if (node == NULL) {
        return 0;
    }
    return node->val + calculate_total_sum_initial_pass(node->left) + calculate_total_sum_initial_pass(node->right);
}

int maxProduct(struct TreeNode* root) {
    // Initialize global variables before starting the calculation
    totalSum_global = 0;
    maxProductValue_global = 0;

    // First pass: Calculate the total sum of all nodes in the tree.
    // This sum is needed to determine the sum of the second part of the tree after a split.
    totalSum_global = calculate_total_sum_initial_pass(root);

    // Second pass: Traverse the tree again. For each subtree, calculate its sum
    // and update the maximum product by considering a split at that subtree's root.
    dfs_calculate_subtree_sum_and_update_max_product(root);

    // The problem asks for the result modulo 10^9 + 7.
    // The modulo operation is applied only to the final maximum product.
    return (int)(maxProductValue_global % 1000000007);
}