var preorder = function(root) {
    const result = [];
    const traverse = (node) => {
        if (!node) return;
        result.push(node.val);
        for (const child of node.children) {
            traverse(child);
        }
    };
    traverse(root);
    return result;
};