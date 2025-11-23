function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}

var maxPathSum = function(root) {
    let maxSum = -Infinity;

    function dfs(node) {
        if (!node) return 0;

        const left = Math.max(0, dfs(node.left));
        const right = Math.max(0, dfs(node.right));

        const currentMax = node.val + left + right;
        maxSum = Math.max(maxSum, currentMax);

        return node.val + Math.max(left, right);
    }

    dfs(root);
    return maxSum;
};