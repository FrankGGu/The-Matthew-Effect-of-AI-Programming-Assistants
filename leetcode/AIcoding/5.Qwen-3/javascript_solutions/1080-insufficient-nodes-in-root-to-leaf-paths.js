var sufficientSubset = function(root, limit) {
    const dfs = (node, currentSum) => {
        if (!node) return null;
        currentSum += node.val;
        if (!node.left && !node.right) {
            return currentSum < limit ? null : node;
        }
        node.left = dfs(node.left, currentSum);
        node.right = dfs(node.right, currentSum);
        return node.left || node.right ? node : null;
    };
    return dfs(root, 0);
};