var sufficientSubset = function(root, limit) {
    const dfs = (node, sum) => {
        if (!node) return null;
        sum += node.val;
        if (!node.left && !node.right) {
            return sum < limit ? null : node;
        }
        node.left = dfs(node.left, sum);
        node.right = dfs(node.right, sum);
        return node.left || node.right ? node : null;
    };
    return dfs(root, 0);
};