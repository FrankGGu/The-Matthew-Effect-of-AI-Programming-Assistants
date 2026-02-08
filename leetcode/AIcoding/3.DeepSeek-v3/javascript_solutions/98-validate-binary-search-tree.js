var isValidBST = function(root) {
    const helper = (node, lower, upper) => {
        if (!node) return true;
        if (node.val <= lower || node.val >= upper) return false;
        return helper(node.left, lower, node.val) && helper(node.right, node.val, upper);
    };
    return helper(root, -Infinity, Infinity);
};