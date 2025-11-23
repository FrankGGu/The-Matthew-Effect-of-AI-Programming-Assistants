var delNodes = function(root, to_delete) {
    const toDeleteSet = new Set(to_delete);
    const result = [];

    function dfs(node, isRoot) {
        if (!node) {
            return null;
        }

        const deleted = toDeleteSet.has(node.val);

        if (isRoot && !deleted) {
            result.push(node);
        }

        node.left = dfs(node.left, deleted);
        node.right = dfs(node.right, deleted);

        return deleted ? null : node;
    }

    dfs(root, true);

    return result;
};