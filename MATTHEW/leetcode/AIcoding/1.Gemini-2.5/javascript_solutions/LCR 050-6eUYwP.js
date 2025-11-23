var pathSum = function(root, targetSum) {
    let count = 0;
    let prefixSumCount = new Map();
    prefixSumCount.set(0, 1);

    function dfs(node, currentSum) {
        if (!node) {
            return;
        }

        currentSum += node.val;

        if (prefixSumCount.has(currentSum - targetSum)) {
            count += prefixSumCount.get(currentSum - targetSum);
        }

        prefixSumCount.set(currentSum, (prefixSumCount.get(currentSum) || 0) + 1);

        dfs(node.left, currentSum);
        dfs(node.right, currentSum);

        prefixSumCount.set(currentSum, prefixSumCount.get(currentSum) - 1);
    }

    dfs(root, 0);
    return count;
};