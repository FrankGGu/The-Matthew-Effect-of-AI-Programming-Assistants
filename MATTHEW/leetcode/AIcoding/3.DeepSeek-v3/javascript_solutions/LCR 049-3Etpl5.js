var sumNumbers = function(root) {
    let total = 0;

    function dfs(node, currentSum) {
        if (!node) return;

        currentSum = currentSum * 10 + node.val;

        if (!node.left && !node.right) {
            total += currentSum;
            return;
        }

        dfs(node.left, currentSum);
        dfs(node.right, currentSum);
    }

    dfs(root, 0);
    return total;
};