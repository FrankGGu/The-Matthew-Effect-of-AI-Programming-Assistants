var getMinimumDifference = function(root) {
    let minDiff = Infinity;
    let prev = null;

    function inOrder(node) {
        if (!node) return;
        inOrder(node.left);
        if (prev !== null) {
            minDiff = Math.min(minDiff, node.val - prev);
        }
        prev = node.val;
        inOrder(node.right);
    }

    inOrder(root);
    return minDiff;
};