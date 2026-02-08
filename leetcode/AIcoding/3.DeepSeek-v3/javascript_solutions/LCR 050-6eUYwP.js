var pathSum = function(root, targetSum) {
    let count = 0;
    const prefixSum = new Map();
    prefixSum.set(0, 1);

    const dfs = (node, currentSum) => {
        if (!node) return;

        currentSum += node.val;
        count += prefixSum.get(currentSum - targetSum) || 0;

        prefixSum.set(currentSum, (prefixSum.get(currentSum) || 0) + 1);

        dfs(node.left, currentSum);
        dfs(node.right, currentSum);

        prefixSum.set(currentSum, prefixSum.get(currentSum) - 1);
    };

    dfs(root, 0);
    return count;
};