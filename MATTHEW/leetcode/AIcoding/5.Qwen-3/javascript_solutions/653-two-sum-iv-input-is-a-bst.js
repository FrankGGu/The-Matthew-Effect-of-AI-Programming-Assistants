function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}

var findTarget = function(root, k) {
    const set = new Set();

    function dfs(node) {
        if (!node) return false;
        if (set.has(k - node.val)) return true;
        set.add(node.val);
        return dfs(node.left) || dfs(node.right);
    }

    return dfs(root);
};