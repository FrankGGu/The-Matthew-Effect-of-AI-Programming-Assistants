function TreeNode(val, left, right) {
    this.val = (val === undefined ? 0 : val);
    this.left = (left === undefined ? null : left);
    this.right = (right === undefined ? null : right);
}

var sumRootToLeaf = function(root) {
    let total = 0;

    const dfs = (node, current) => {
        if (!node) return;
        current = (current << 1) | node.val;
        if (!node.left && !node.right) {
            total += current;
            return;
        }
        dfs(node.left, current);
        dfs(node.right, current);
    };

    dfs(root, 0);
    return total;
};