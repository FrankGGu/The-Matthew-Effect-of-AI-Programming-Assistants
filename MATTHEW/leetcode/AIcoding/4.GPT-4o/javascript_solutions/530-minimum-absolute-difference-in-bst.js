var getMinimumDifference = function(root) {
    let minDiff = Infinity;
    let prev = null;

    const inOrderTraversal = (node) => {
        if (!node) return;
        inOrderTraversal(node.left);
        if (prev !== null) {
            minDiff = Math.min(minDiff, node.val - prev);
        }
        prev = node.val;
        inOrderTraversal(node.right);
    };

    inOrderTraversal(root);
    return minDiff;
};