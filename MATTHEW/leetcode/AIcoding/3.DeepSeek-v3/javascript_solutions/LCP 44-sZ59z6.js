var numColor = function(root) {
    const colorSet = new Set();
    const traverse = (node) => {
        if (!node) return;
        colorSet.add(node.val);
        traverse(node.left);
        traverse(node.right);
    };
    traverse(root);
    return colorSet.size;
};