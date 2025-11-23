var evaluateTree = function(root) {
    if (!root.left && !root.right) {
        return root.val === 1;
    }

    let leftResult = evaluateTree(root.left);
    let rightResult = evaluateTree(root.right);

    if (root.val === 2) {
        return leftResult || rightResult;
    } else {
        return leftResult && rightResult;
    }
};