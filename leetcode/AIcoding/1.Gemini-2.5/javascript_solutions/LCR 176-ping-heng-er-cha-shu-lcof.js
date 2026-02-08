var isBalanced = function(root) {
    function checkHeight(node) {
        if (node === null) {
            return 0;
        }

        const leftHeight = checkHeight(node.left);
        if (leftHeight === -1) {
            return -1;
        }

        const rightHeight = checkHeight(node.right);
        if (rightHeight === -1) {
            return -1;
        }

        if (Math.abs(leftHeight - rightHeight) > 1) {
            return -1;
        }

        return Math.max(leftHeight, rightHeight) + 1;
    }

    return checkHeight(root) !== -1;
};