var maxPathSum = function(root) {
    let maxSum = -Infinity;

    function dfs(node) {
        if (!node) {
            return 0;
        }

        let leftSum = Math.max(0, dfs(node.left));
        let rightSum = Math.max(0, dfs(node.right));

        let currentPathSum = node.val + leftSum + rightSum;
        maxSum = Math.max(maxSum, currentPathSum);

        return node.val + Math.max(leftSum, rightSum);
    }

    dfs(root);
    return maxSum;
};