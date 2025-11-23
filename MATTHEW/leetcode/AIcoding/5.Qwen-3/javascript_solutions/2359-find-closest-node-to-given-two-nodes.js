function closestNode(root, x, y) {
    let result = null;
    let minDistance = Infinity;

    function dfs(node, target, path) {
        if (!node) return null;
        const newPath = [...path, node.val];
        if (node.val === target) {
            return newPath;
        }
        const left = dfs(node.left, target, newPath);
        if (left) return left;
        return dfs(node.right, target, newPath);
    }

    const pathX = dfs(root, x, []);
    const pathY = dfs(root, y, []);

    const length = Math.min(pathX.length, pathY.length);
    for (let i = 0; i < length; i++) {
        if (pathX[i] !== pathY[i]) break;
        if (i === length - 1 || pathX[i + 1] !== pathY[i + 1]) {
            result = pathX[i];
            break;
        }
    }

    return result;
}