var preorderTraversal = function(root) {
    const result = [];
    const traverse = (node) => {
        if (!node) return;
        result.push(node.val);
        traverse(node.left);
        traverse(node.right);
    };
    traverse(root);
    return result;
};