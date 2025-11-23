var maxAncestorDiff = function(root) {
    let maxDiff = 0;

    function dfs(node, currentMin, currentMax) {
        if (!node) {
            return;
        }

        maxDiff = Math.max(maxDiff, Math.abs(node.val - currentMin), Math.abs(node.val - currentMax));

        const newMin = Math.min(currentMin, node.val);
        const newMax = Math.max(currentMax, node.val);

        dfs(node.left, newMin, newMax);
        dfs(node.right, newMin, newMax);
    }

    dfs(root, root.val, root.val);

    return maxDiff;
};