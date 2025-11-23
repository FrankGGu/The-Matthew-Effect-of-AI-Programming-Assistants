function isBalanced(root) {
    function height(node) {
        if (!node) return 0;
        const leftHeight = height(node.left);
        if (leftHeight === -1) return -1;
        const rightHeight = height(node.right);
        if (rightHeight === -1) return -1;
        if (Math.abs(leftHeight - rightHeight) > 1) return -1;
        return Math.max(leftHeight, rightHeight) + 1;
    }
    return height(root) !== -1;
}