static int max_depth_found;
static int bottom_left_value_result;

void dfs_find_bottom_left(struct TreeNode* node, int current_depth) {
    if (node == NULL) {
        return;
    }

    // If we have reached a new maximum depth, this node must be the leftmost
    // at this depth because we traverse the left subtree before the right subtree.
    if (current_depth > max_depth_found) {
        max_depth_found = current_depth;
        bottom_left_value_result = node->val;
    }

    // Recursively traverse the left subtree first
    dfs_find_bottom_left(node->left, current_depth + 1);

    // Then recursively traverse the right subtree
    dfs_find_bottom_left(node->right, current_depth + 1);
}

int findBottomLeftValue(struct TreeNode* root) {
    // Initialize global variables before starting the DFS
    // max_depth_found is initialized to -1 because the root node is at depth 0.
    max_depth_found = -1;
    // bottom_left_value_result will be updated by the DFS.
    // Its initial value doesn't strictly matter as it will be overwritten.
    bottom_left_value_result = 0; 

    // Start the DFS traversal from the root node at depth 0
    dfs_find_bottom_left(root, 0);

    return bottom_left_value_result;
}