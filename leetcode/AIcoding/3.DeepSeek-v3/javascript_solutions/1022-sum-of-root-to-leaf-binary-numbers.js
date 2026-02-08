var sumRootToLeaf = function(root) {
    let totalSum = 0;

    function dfs(node, currentSum) {
        if (!node) return;

        currentSum = (currentSum << 1) | node.val;

        if (!node.left && !node.right) {
            totalSum += currentSum;
            return;
        }

        dfs(node.left, currentSum);
        dfs(node.right, currentSum);
    }

    dfs(root, 0);
    return totalSum;
};