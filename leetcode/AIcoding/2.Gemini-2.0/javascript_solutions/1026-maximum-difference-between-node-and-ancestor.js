var maxAncestorDiff = function(root) {
    let maxDiff = 0;

    function dfs(node, maxAncestor, minAncestor) {
        if (!node) {
            return;
        }

        maxDiff = Math.max(maxDiff, Math.abs(node.val - maxAncestor), Math.abs(node.val - minAncestor));

        maxAncestor = Math.max(maxAncestor, node.val);
        minAncestor = Math.min(minAncestor, node.val);

        dfs(node.left, maxAncestor, minAncestor);
        dfs(node.right, maxAncestor, minAncestor);
    }

    dfs(root, root.val, root.val);
    return maxDiff;
};