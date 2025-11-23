var sumOfLeftLeaves = function(root) {
    let sum = 0;

    function traverse(node, isLeft) {
        if (!node) {
            return;
        }

        if (!node.left && !node.right && isLeft) {
            sum += node.val;
        }

        traverse(node.left, true);
        traverse(node.right, false);
    }

    traverse(root, false);
    return sum;
};