var isBalanced = function(root) {
    if (!root) return true;

    function getHeight(node) {
        if (!node) return 0;
        return 1 + Math.max(getHeight(node.left), getHeight(node.right));
    }

    const leftHeight = getHeight(root.left);
    const rightHeight = getHeight(root.right);

    return Math.abs(leftHeight - rightHeight) <= 1 && isBalanced(root.left) && isBalanced(root.right);
};