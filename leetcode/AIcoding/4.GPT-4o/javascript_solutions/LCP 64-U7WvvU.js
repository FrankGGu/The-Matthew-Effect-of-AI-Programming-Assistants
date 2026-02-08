var minCameraCover = function(root) {
    let cameras = 0;

    const dfs = (node) => {
        if (!node) return 1; // null node is covered
        const left = dfs(node.left);
        const right = dfs(node.right);

        if (left === 0 || right === 0) {
            cameras++;
            return 2; // this node has a camera
        }
        return left === 2 || right === 2 ? 1 : 0; // return status
    };

    if (dfs(root) === 0) cameras++; // root needs a camera
    return cameras;
};