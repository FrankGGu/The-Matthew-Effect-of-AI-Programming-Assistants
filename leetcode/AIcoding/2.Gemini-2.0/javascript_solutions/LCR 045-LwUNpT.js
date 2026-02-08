var findBottomLeftValue = function(root) {
    let bottomLeft = 0;
    let maxDepth = -1;

    function dfs(node, depth) {
        if (!node) {
            return;
        }

        if (depth > maxDepth) {
            maxDepth = depth;
            bottomLeft = node.val;
        }

        dfs(node.left, depth + 1);
        dfs(node.right, depth + 1);
    }

    dfs(root, 0);
    return bottomLeft;
};