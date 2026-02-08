var sufficientSubset = function(root, limit) {
    function dfs(node, sumToParent) {
        if (!node) {
            return null;
        }

        let currentPathSum = sumToParent + node.val;

        if (!node.left && !node.right) {
            if (currentPathSum < limit) {
                return null;
            } else {
                return node;
            }
        }

        node.left = dfs(node.left, currentPathSum);
        node.right = dfs(node.right, currentPathSum);

        if (!node.left && !node.right) {
            if (currentPathSum < limit) {
                return null;
            } else {
                return node;
            }
        }

        return node;
    }

    return dfs(root, 0);
};