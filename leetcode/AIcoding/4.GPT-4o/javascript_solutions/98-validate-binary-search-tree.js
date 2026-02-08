var isValidBST = function(root) {
    const validate = (node, low, high) => {
        if (!node) return true;
        if (node.val <= low || node.val >= high) return false;
        return validate(node.left, low, node.val) && validate(node.right, node.val, high);
    };
    return validate(root, -Infinity, Infinity);
};