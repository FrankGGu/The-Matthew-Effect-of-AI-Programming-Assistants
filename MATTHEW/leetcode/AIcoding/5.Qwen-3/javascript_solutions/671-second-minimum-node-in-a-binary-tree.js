function TreeNode(val) {
    this.val = val;
    this.left = null;
    this.right = null;
}

var findSecondMinimumValue = function(root) {
    let result = [Infinity, Infinity];

    function dfs(node) {
        if (!node) return;
        if (node.val < result[0]) {
            result[1] = result[0];
            result[0] = node.val;
        } else if (node.val > result[0] && node.val < result[1]) {
            result[1] = node.val;
        }
        dfs(node.left);
        dfs(node.right);
    }

    dfs(root);

    return result[1] === Infinity ? -1 : result[1];
};