var getMinimumDifference = function(root) {
    let prev = null;
    let minDiff = Infinity;

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