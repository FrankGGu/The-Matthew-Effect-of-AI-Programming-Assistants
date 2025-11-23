var sumOfLeftLeaves = function(root) {
    if (!root) return 0;

    let sum = 0;

    function traverse(node, isLeft) {
        if (!node.left && !node.right && isLeft) {
            sum += node.val;
            return;
        }
        if (node.left) traverse(node.left, true);
        if (node.right) traverse(node.right, false);
    }

    traverse(root, false);
    return sum;
};