var minCameraCover = function(root) {
    let cameras = 0;

    // States for a node:
    // 0: Node needs a camera (not covered by children, doesn't have one)
    // 1: Node has a camera
    // 2: Node is covered (by a child's camera or its parent's camera)

    // Helper function performs a post-order traversal (bottom-up)
    // Returns the state of the current node
    function dfs(node) {
        if (node === null) {
            return 2; // Null nodes are considered covered and don't need a camera
        }

        let leftState = dfs(node.left);
        let rightState = dfs(node.right);

        // Case 1: If any child needs a camera (state 0), the current node MUST place a camera
        // to cover that child. This is the greedy choice to satisfy the lowest unmonitored node.
        if (leftState === 0 || rightState === 0) {
            cameras++;
            return 1; // Current node has a camera
        }

        // Case 2: If any child has a camera (state 1), the current node is covered by that child's camera.
        // It does not need to place a camera itself.
        if (leftState === 1 || rightState === 1) {
            return 2; // Current node is covered
        }

        // Case 3: If both children are covered (state 2) but do not have cameras themselves,
        // the current node is not covered by its children. It also doesn't have a camera.
        // Therefore, it needs its parent to cover it.
        return 0; // Current node needs a camera (from its parent)
    }

    // After the traversal, if the root itself needs a camera (state 0),
    // it has no parent to cover it, so we must place a camera at the root.
    if (dfs(root) === 0) {
        cameras++;
    }

    return cameras;
};