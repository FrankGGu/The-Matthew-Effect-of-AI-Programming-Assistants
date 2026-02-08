var maxPathSum = function(root) {
    let maxSum = -Infinity;

    const dfs = (node) => {
        if (!node) return 0;

        let left = Math.max(0, dfs(node.left));
        let right = Math.max(0, dfs(node.right));

        maxSum = Math.max(maxSum, left + right + node.val);

        return Math.max(left, right) + node.val;
    };

    dfs(root);
    return maxSum;
};