var goodNodes = function(root) {
    if (!root) {
        return 0;
    }

    let count = 0;

    function dfs(node, maxSoFar) {
        if (!node) {
            return;
        }

        if (node.val >= maxSoFar) {
            count++;
        }

        maxSoFar = Math.max(maxSoFar, node.val);

        dfs(node.left, maxSoFar);
        dfs(node.right, maxSoFar);
    }

    dfs(root, -Infinity);

    return count;
};