var isCousins = function(root, x, y) {
    let xParent = null;
    let yParent = null;
    let xDepth = -1;
    let yDepth = -1;

    function dfs(node, parent, depth) {
        if (!node) return;

        if (node.val === x) {
            xParent = parent;
            xDepth = depth;
        }

        if (node.val === y) {
            yParent = parent;
            yDepth = depth;
        }

        dfs(node.left, node, depth + 1);
        dfs(node.right, node, depth + 1);
    }

    dfs(root, null, 0);

    return xDepth === yDepth && xParent !== yParent;
};