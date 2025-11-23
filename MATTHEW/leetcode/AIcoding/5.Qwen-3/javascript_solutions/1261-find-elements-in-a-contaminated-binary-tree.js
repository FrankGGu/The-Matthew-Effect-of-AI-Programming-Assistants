var FindElements = function(root) {
    this.set = new Set();
    const dfs = (node, val) => {
        if (!node) return;
        node.val = val;
        this.set.add(val);
        dfs(node.left, 2 * val + 1);
        dfs(node.right, 2 * val + 2);
    };
    dfs(root, 0);
};

FindElements.prototype.find = function(target) {
    return this.set.has(target);
};