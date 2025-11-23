function TreeNode(val, left, right) {
    this.val = (val === undefined ? 0 : val)
    this.left = (left === undefined ? null : left)
    this.right = (right === undefined ? null : right)
}

var pathSum = function(root, targetSum) {
    const prefixSum = new Map();
    prefixSum.set(0, 1);

    function dfs(node, currentSum) {
        if (!node) return 0;

        currentSum += node.val;
        let count = 0;

        if (prefixSum.has(currentSum - targetSum)) {
            count += prefixSum.get(currentSum - targetSum);
        }

        prefixSum.set(currentSum, (prefixSum.get(currentSum) || 0) + 1);

        count += dfs(node.left, currentSum);
        count += dfs(node.right, currentSum);

        prefixSum.set(currentSum, prefixSum.get(currentSum) - 1);

        return count;
    }

    return dfs(root, 0);
};