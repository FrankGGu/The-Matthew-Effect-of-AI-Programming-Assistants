var lcaDeepestLeaves = function(root) {
    let maxDepth = 0;
    let result = null;

    function dfs(node, depth) {
        if (!node) return depth;
        maxDepth = Math.max(maxDepth, depth);
        const left = dfs(node.left, depth + 1);
        const right = dfs(node.right, depth + 1);
        if (left === maxDepth && right === maxDepth) {
            result = node;
        }
        return Math.max(left, right);
    }

    dfs(root, 0);
    return result;
};