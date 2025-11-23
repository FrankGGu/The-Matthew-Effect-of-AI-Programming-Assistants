var postorderTraversal = function(root) {
    const result = [];
    const traverse = (node) => {
        if (!node) return;
        traverse(node.left);
        traverse(node.right);
        result.push(node.val);
    };
    traverse(root);
    return result;
};