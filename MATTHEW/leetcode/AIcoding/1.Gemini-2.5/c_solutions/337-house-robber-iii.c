#include <stdlib.h> // For malloc, free

int max(int a, int b) {
    return (a > b) ? a : b;
}

int* dfs(struct TreeNode* node) {
    // Allocate memory for the result array [not_robbed_val, robbed_val]
    int* res = (int*)malloc(sizeof(int) * 2);

    // Base case: If the node is NULL, no money can be obtained
    if (node == NULL) {
        res[0] = 0; // Not robbed
        res[1] = 0; // Robbed
        return res;
    }

    // Recursively get results for left and right children
    int* left_res = dfs(node->left);
    int* right_res = dfs(node->right);

    // Calculate result[0]: Current node is NOT robbed
    // If the current node is not robbed, its children can be robbed or not.
    // To maximize, we take the maximum of (rob or not rob) for each child.
    res[0] = max(left_res[0], left_res[1]) + max(right_res[0], right_res[1]);

    // Calculate result[1]: Current node IS robbed
    // If the current node is robbed, its children CANNOT be robbed.
    // So, we must take the "not robbed" value for its children.
    res[1] = node->val + left_res[0] + right_res[0];

    // Free memory allocated for children's results to prevent memory leaks
    free(left_res);
    free(right_res);

    return res;
}

int rob(struct TreeNode* root) {
    // Call the helper function for the root node
    int* final_res = dfs(root);

    // The maximum amount is the maximum of (root not robbed, root robbed)
    int result = max(final_res[0], final_res[1]);

    // Free memory allocated for the root's result
    free(final_res);

    return result;
}