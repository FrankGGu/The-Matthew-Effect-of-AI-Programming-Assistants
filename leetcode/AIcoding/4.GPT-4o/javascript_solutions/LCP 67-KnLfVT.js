var decorateTree = function(root) {
    if (!root) return null;

    const dfs = (node) => {
        if (!node) return null;

        const left = dfs(node.left);
        const right = dfs(node.right);

        node.left = left ? left : null;
        node.right = right ? right : null;

        return node;
    };

    return dfs(root);
};