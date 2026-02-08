var maxAncestorDiff = function(root) {
    let maxDiff = 0;

    const dfs = (node, min, max) => {
        if (!node) return;
        min = Math.min(min, node.val);
        max = Math.max(max, node.val);
        maxDiff = Math.max(maxDiff, max - min);
        dfs(node.left, min, max);
        dfs(node.right, min, max);
    };

    dfs(root, root.val, root.val);
    return maxDiff;
};