var maxAncestorDiff = function(root) {
    function dfs(node, minVal, maxVal) {
        if (!node) return 0;
        let currentMax = Math.max(maxVal, node.val);
        let currentMin = Math.min(minVal, node.val);
        let left = dfs(node.left, currentMin, currentMax);
        let right = dfs(node.right, currentMin, currentMax);
        return Math.max(currentMax - currentMin, left, right);
    }
    return dfs(root, root.val, root.val);
};