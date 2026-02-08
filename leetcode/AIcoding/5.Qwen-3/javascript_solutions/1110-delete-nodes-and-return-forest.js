function TreeNode(val, left, right) {
    this.val = (val === undefined ? 0 : val)
    this.left = (left === undefined ? null : left)
    this.right = (right === undefined ? null : right)
}

var delNodes = function(root, toDelete) {
    const toDeleteSet = new Set(toDelete);
    const result = [];

    const dfs = function(node) {
        if (!node) return null;

        node.left = dfs(node.left);
        node.right = dfs(node.right);

        if (toDeleteSet.has(node.val)) {
            if (node.left) result.push(node.left);
            if (node.right) result.push(node.right);
            return null;
        }

        return node;
    };

    if (!toDeleteSet.has(root.val)) {
        result.push(root);
    }

    dfs(root);
    return result;
};