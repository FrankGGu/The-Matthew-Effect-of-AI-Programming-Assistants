var subtreeWithAllDeepest = function(root) {
    let deepest = 0;
    let result = null;

    function dfs(node, depth) {
        if (!node) {
            return depth;
        }

        let leftDepth = dfs(node.left, depth + 1);
        let rightDepth = dfs(node.right, depth + 1);

        deepest = Math.max(deepest, leftDepth, rightDepth);

        if (leftDepth === deepest && rightDepth === deepest) {
            result = node;
        } else if (leftDepth === deepest) {
            return leftDepth;
        } else if (rightDepth === deepest) {
            return rightDepth;
        }

        return Math.max(leftDepth, rightDepth);
    }

    dfs(root, 0);
    return result;
};