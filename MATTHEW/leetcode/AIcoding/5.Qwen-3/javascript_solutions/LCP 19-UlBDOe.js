function collectTheCoins(root) {
    function dfs(node) {
        if (!node) return 0;
        const left = dfs(node.left);
        const right = dfs(node.right);
        if (left === 0 && right === 0) return 1;
        return left + right;
    }

    function prune(node) {
        if (!node) return null;
        node.left = prune(node.left);
        node.right = prune(node.right);
        if (node.left === null && node.right === null) return null;
        return node;
    }

    const depth = dfs(root);
    if (depth <= 1) return 0;

    const prunedRoot = prune(root);
    const prunedDepth = dfs(prunedRoot);
    return Math.max(0, prunedDepth - 1) * 2;
}