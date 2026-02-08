function TreeNode(val) {
    this.val = val;
    this.left = null;
    this.right = null;
}

var sumNumbers = function(root) {
    function dfs(node, currentSum) {
        if (!node) return 0;
        currentSum = currentSum * 10 + node.val;
        if (!node.left && !node.right) {
            return currentSum;
        }
        return dfs(node.left, currentSum) + dfs(node.right, currentSum);
    }
    return dfs(root, 0);
};