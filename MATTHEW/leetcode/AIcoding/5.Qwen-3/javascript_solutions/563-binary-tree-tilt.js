function TreeNode(val) {
    this.val = val;
    this.left = null;
    this.right = null;
}

var findTilt = function(root) {
    let tilt = 0;

    function dfs(node) {
        if (!node) return 0;

        const left = dfs(node.left);
        const right = dfs(node.right);
        tilt += Math.abs(left - right);

        return left + right + node.val;
    }

    dfs(root);
    return tilt;
};