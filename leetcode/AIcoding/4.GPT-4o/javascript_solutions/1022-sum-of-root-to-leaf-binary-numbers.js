var sumBinaryNumbers = function(root) {
    let totalSum = 0;

    function dfs(node, current) {
        if (!node) return;
        current = (current << 1) | node.val;
        if (!node.left && !node.right) {
            totalSum += current;
        } else {
            dfs(node.left, current);
            dfs(node.right, current);
        }
    }

    dfs(root, 0);
    return totalSum;
};