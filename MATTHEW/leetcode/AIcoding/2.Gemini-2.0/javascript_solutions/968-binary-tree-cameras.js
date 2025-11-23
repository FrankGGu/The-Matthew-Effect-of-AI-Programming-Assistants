var minCameraCover = function(root) {
    let cameras = 0;

    function dfs(node) {
        if (!node) {
            return 1; // Covered
        }

        const left = dfs(node.left);
        const right = dfs(node.right);

        if (left === 0 || right === 0) {
            cameras++;
            return 2; // Camera
        }

        if (left === 2 || right === 2) {
            return 1; // Covered
        }

        return 0; // Need Cover
    }

    if (dfs(root) === 0) {
        cameras++;
    }

    return cameras;
};