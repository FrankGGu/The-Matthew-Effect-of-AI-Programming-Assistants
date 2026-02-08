int totalCameras;

int dfs(struct TreeNode* node) {
    if (node == NULL) {
        return 1; // A null node is considered monitored and doesn't need a camera
    }

    int leftState = dfs(node->left);
    int rightState = dfs(node->right);

    // Case 1: If any child needs a camera (state 0), the current node MUST have a camera.
    if (leftState == 0 || rightState == 0) {
        totalCameras++;
        return 2; // Current node has a camera
    }

    // Case 2: If any child has a camera (state 2), the current node is monitored by its child.
    // It doesn't need a camera itself.
    if (leftState == 2 || rightState == 2) {
        return 1; // Current node is monitored, no camera
    }

    // Case 3: Both children are state 1 (monitored, no camera).
    // The current node is not monitored by its children and does not have a camera.
    // It needs its parent to monitor it.
    return 0; // Current node needs a camera/to be monitored
}

int minCameraCover(struct TreeNode* root) {
    totalCameras = 0; // Initialize the camera counter

    // Start DFS from the root.
    // If the root returns state 0 (needs to be monitored), it means
    // it was not covered by any child and has no parent. So, we must place a camera on it.
    if (dfs(root) == 0) {
        totalCameras++;
    }

    return totalCameras;
}