var sufficientSubset = function(root, limit) {
    const helper = (node, sum) => {
        if (!node) return null;
        sum += node.val;
        if (!node.left && !node.right) {
            return sum < limit ? null : node;
        }
        node.left = helper(node.left, sum);
        node.right = helper(node.right, sum);
        return !node.left && !node.right ? null : node;
    };
    return helper(root, 0);
};