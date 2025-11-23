var isUnivalTree = function(root) {
    if (!root) return true;
    const val = root.val;
    const traverse = (node) => {
        if (!node) return true;
        if (node.val !== val) return false;
        return traverse(node.left) && traverse(node.right);
    };
    return traverse(root);
};