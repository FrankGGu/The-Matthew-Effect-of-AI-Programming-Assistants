var evaluateTree = function(root) {
    if (!root.left && !root.right) {
        return root.val === 1;
    }
    const left = evaluateTree(root.left);
    const right = evaluateTree(root.right);
    if (root.val === 2) {
        return left || right;
    } else {
        return left && right;
    }
};