int g_cameras;

int dfs(struct TreeNode* node) {
    // Base case: A null node is considered covered and doesn't require a camera.
    if (!node) {
        return 2;
    }

    // Recursively get the state of the left and right children.
    int left_state = dfs(node->left);
    int right_state = dfs(node->right);

    // Rule 1: If any child is not covered (state 0), we *must* place a camera on the current node.
    // This camera will cover the current node, its parent, and its children.
    if (left_state == 0 || right_state == 0) {
        g_cameras++;
        return 1; // Current node has a camera.
    }

    // Rule 2: If any child has a camera (state 1), the current node is covered by its child.
    // The current node does not need a camera itself.
    if (left_state == 1 || right_state == 1) {
        return 2; // Current node is covered by a child.
    }

    // Rule 3: If both children are covered (state 2) but neither has a camera (not state 1),
    // and neither is uncovered (not state 0), it means the children are fine,
    // but they do not cover the current node. The current node itself is not covered
    // and doesn't have a camera. It needs its parent to cover it.
    return 0; // Current node is not covered.
}

int minCameraCover(struct TreeNode* root) {
    // Initialize the global camera count for each test case.
    g_cameras = 0;

    // Perform DFS starting from the root.
    int root_state = dfs(root);

    // After the DFS, if the root node itself is not covered (state 0),
    // it means its (non-existent) parent cannot cover it.
    // Therefore, we must place a camera on the root.
    if (root_state == 0) {
        g_cameras++;
    }

    return g_cameras;
}