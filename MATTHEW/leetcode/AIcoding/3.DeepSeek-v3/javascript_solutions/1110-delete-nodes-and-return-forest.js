var delNodes = function(root, to_delete) {
    const toDelete = new Set(to_delete);
    const result = [];

    const traverse = (node, isRoot) => {
        if (!node) return null;
        const shouldDelete = toDelete.has(node.val);
        if (isRoot && !shouldDelete) {
            result.push(node);
        }
        node.left = traverse(node.left, shouldDelete);
        node.right = traverse(node.right, shouldDelete);
        return shouldDelete ? null : node;
    };

    traverse(root, true);
    return result;
};