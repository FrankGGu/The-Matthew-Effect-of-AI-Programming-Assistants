function preorder(root) {
    const result = [];
    function traverse(node) {
        if (!node) return;
        result.push(node.val);
        for (const child of node.children) {
            traverse(child);
        }
    }
    traverse(root);
    return result;
}