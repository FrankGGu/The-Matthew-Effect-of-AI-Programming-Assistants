var maxAncestorDiff = function(root) {
    if (!root) return 0;

    let maxDiff = 0;

    const dfs = (node, min, max) => {
        if (!node) return;

        const currentMin = Math.min(min, node.val);
        const currentMax = Math.max(max, node.val);

        maxDiff = Math.max(maxDiff, currentMax - currentMin);

        dfs(node.left, currentMin, currentMax);
        dfs(node.right, currentMin, currentMax);
    };

    dfs(root, root.val, root.val);

    return maxDiff;
};