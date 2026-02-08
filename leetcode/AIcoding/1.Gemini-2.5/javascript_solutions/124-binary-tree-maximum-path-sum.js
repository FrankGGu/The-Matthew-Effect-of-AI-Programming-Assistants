var maxPathSum = function(root) {
    let maxSum = -Infinity;

    function dfs(node) {
        if (!node) {
            return 0;
        }

        let leftGain = Math.max(0, dfs(node.left));
        let rightGain = Math.max(0, dfs(node.right));

        let currentPathSum = node.val + leftGain + rightGain;
        maxSum = Math.max(maxSum, currentPathSum);

        return node.val + Math.max(leftGain, rightGain);
    }

    dfs(root);
    return maxSum;
};