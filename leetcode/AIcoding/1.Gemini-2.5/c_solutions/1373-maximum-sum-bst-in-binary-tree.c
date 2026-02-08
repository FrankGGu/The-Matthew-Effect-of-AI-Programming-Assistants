#include <stdlib.h> // For malloc, free
#include <limits.h> // For INT_MIN, INT_MAX

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

static int max_sum_bst_global;

static int* dfs(struct TreeNode* node) {
    int* res = (int*)malloc(sizeof(int) * 4);
    if (!node) {
        res[0] = 1;         // is_bst: An empty tree is a BST
        res[1] = INT_MAX;   // min_val: For an empty tree, min is effectively infinite for parent checks
        res[2] = INT_MIN;   // max_val: For an empty tree, max is effectively negative infinite for parent checks
        res[3] = 0;         // sum: Sum of an empty tree is 0
        return res;
    }

    int* left_res = dfs(node->left);
    int* right_res = dfs(node->right);

    // Check if the current subtree rooted at 'node' is a BST
    // Conditions:
    // 1. Left subtree must be a BST.
    // 2. Right subtree must be a BST.
    // 3. Current node's value must be greater than the maximum value in the left subtree.
    // 4. Current node's value must be less than the minimum value in the right subtree.
    if (left_res[0] == 1 && right_res[0] == 1 &&
        node->val > left_res[2] && node->val < right_res[1]) {

        // This subtree is a BST
        res[0] = 1;
        // The minimum value in this BST is either the node's value (if no left child)
        // or the minimum value from the left subtree.
        res[1] = (node->left) ? left_res[1] : node->val;
        // The maximum value in this BST is either the node's value (if no right child)
        // or the maximum value from the right subtree.
        res[2] = (node->right) ? right_res[2] : node->val;
        // The sum of this BST is the sum of left, right subtrees plus current node's value.
        res[3] = left_res[3] + right_res[3] + node->val;

        // Update the global maximum sum found
        if (res[3] > max_sum_bst_global) {
            max_sum_bst_global = res[3];
        }
    } else {
        // This subtree is NOT a BST
        res[0] = 0;
        // If it's not a BST, its min/max values should be set such that any parent
        // trying to include it will fail the BST condition.
        // For min_val, use INT_MIN to ensure parent's `node->val < res[1]` check fails.
        res[1] = INT_MIN; 
        // For max_val, use INT_MAX to ensure parent's `node->val > res[2]` check fails.
        res[2] = INT_MAX;
        res[3] = 0; // Sum for a non-BST subtree is not considered for max_sum_bst_global
    }

    free(left_res);
    free(right_res);
    return res;
}

int maxSumBST(struct TreeNode* root) {
    max_sum_bst_global = 0; // Initialize global max sum to 0 (an empty BST has sum 0)
    int* final_res = dfs(root);
    free(final_res); // Free the result from the root call
    return max_sum_bst_global;
}