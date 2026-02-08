var sufficientSubset = function(root, limit) {
    function dfs(node, currentSum) {
        if (!node) {
            return false;
        }

        if (!node.left && !node.right) {
            return currentSum + node.val >= limit;
        }

        let leftSufficient = dfs(node.left, currentSum + node.val);
        let rightSufficient = dfs(node.right, currentSum + node.val);

        if (!leftSufficient) {
            node.left = null;
        }
        if (!rightSufficient) {
            node.right = null;
        }

        return leftSufficient || rightSufficient;
    }

    if (!dfs(root, 0)) {
        return null;
    }

    return root;
};