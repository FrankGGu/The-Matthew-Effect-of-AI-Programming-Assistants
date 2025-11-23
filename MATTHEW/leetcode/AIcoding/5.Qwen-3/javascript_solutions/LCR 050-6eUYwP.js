var pathSum = function(root, targetSum) {
    function dfs(node, currentSum) {
        if (!node) return 0;
        currentSum += node.val;
        let count = 0;
        if (currentSum === targetSum) count++;
        count += dfs(node.left, currentSum);
        count += dfs(node.right, currentSum);
        return count;
    }

    if (!root) return 0;
    return dfs(root, 0) + pathSum(root.left, targetSum) + pathSum(root.right, targetSum);
};