var minCameraCover = function(root) {
    let result = 0;

    const dfs = (node) => {
        if (!node) return 2;
        const left = dfs(node.left);
        const right = dfs(node.right);

        if (left === 0 || right === 0) {
            result++;
            return 1;
        }

        if (left === 1 || right === 1) {
            return 2;
        }

        return 0;
    };

    if (dfs(root) === 0) {
        result++;
    }

    return result;
};