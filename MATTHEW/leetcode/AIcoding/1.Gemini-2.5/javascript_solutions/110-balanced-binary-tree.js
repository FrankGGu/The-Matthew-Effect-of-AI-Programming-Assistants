var isBalanced = function(root) {
    function checkHeight(node) {
        if (!node) {
            return 0;
        }

        let leftHeight = checkHeight(node.left);
        if (leftHeight === -1) {
            return -1;
        }

        let rightHeight = checkHeight(node.right);
        if (rightHeight === -1) {
            return -1;
        }

        if (Math.abs(leftHeight - rightHeight) > 1) {
            return -1;
        }

        return 1 + Math.max(leftHeight, rightHeight);
    }

    return checkHeight(root) !== -1;
};