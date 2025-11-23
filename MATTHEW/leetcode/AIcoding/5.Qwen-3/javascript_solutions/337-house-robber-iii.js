function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}

var rob = function(root) {
    if (!root) return 0;

    function dfs(node) {
        if (!node) return [0, 0];

        const left = dfs(node.left);
        const right = dfs(node.right);

        const include = node.val + left[0] + right[0];
        const exclude = Math.max(left[1], left[0]) + Math.max(right[1], right[0]);

        return [include, exclude];
    }

    const result = dfs(root);
    return Math.max(result[0], result[1]);
};