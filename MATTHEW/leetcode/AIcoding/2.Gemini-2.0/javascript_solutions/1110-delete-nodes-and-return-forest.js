var delNodes = function(root, to_delete) {
    const result = [];
    const toDeleteSet = new Set(to_delete);

    function dfs(node, isRoot) {
        if (!node) {
            return null;
        }

        const shouldDelete = toDeleteSet.has(node.val);

        if (isRoot && !shouldDelete) {
            result.push(node);
        }

        node.left = dfs(node.left, shouldDelete);
        node.right = dfs(node.right, shouldDelete);

        return shouldDelete ? null : node;
    }

    dfs(root, true);
    return result;
};