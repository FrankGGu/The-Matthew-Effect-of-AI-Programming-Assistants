var lcaDeepestLeaves = function(root) {
    let deepest = 0;
    let lca = null;

    function dfs(node, depth) {
        if (!node) {
            return depth;
        }

        let leftDepth = dfs(node.left, depth + 1);
        let rightDepth = dfs(node.right, depth + 1);

        if (leftDepth === rightDepth && leftDepth >= deepest) {
            deepest = leftDepth;
            lca = node;
        } else if (leftDepth > rightDepth) {
            return leftDepth;
        } else {
            return rightDepth;
        }

        return deepest;
    }

    dfs(root, 0);
    return lca;
};