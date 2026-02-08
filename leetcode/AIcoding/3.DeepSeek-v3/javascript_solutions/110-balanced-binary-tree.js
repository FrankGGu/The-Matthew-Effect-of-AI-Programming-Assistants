var isBalanced = function(root) {
    function checkHeight(node) {
        if (!node) return 0;
        const left = checkHeight(node.left);
        const right = checkHeight(node.right);
        if (left === -1 || right === -1 || Math.abs(left - right) > 1) return -1;
        return Math.max(left, right) + 1;
    }
    return checkHeight(root) !== -1;
};