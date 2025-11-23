var inorderTraversal = function(root) {
    const result = [];
    const traverse = (node) => {
        if (!node) return;
        traverse(node.left);
        result.push(node.val);
        traverse(node.right);
    };
    traverse(root);
    return result;
};