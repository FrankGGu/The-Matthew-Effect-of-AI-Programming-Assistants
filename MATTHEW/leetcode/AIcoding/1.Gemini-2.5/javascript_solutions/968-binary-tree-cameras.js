var minCameraCover = function(root) {
    let cameras = 0;

    // States:
    // 0: Node needs to be covered by its parent.
    // 1: Node is covered, but does not have a camera.
    // 2: Node has a camera.
    const dfs = (node) => {
        if (node === null) {
            return 1;
        }

        const leftState = dfs(node.left);
        const rightState = dfs(node.right);

        if (leftState === 0 || rightState === 0) {
            cameras++;
            return 2;
        }

        if (leftState === 2 || rightState === 2) {
            return 1;
        }

        return 0;
    };

    if (dfs(root) === 0) {
        cameras++;
    }

    return cameras;
};