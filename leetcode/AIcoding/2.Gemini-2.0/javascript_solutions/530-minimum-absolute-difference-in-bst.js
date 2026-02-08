var getMinimumDifference = function(root) {
    let values = [];
    function inorder(node) {
        if (!node) return;
        inorder(node.left);
        values.push(node.val);
        inorder(node.right);
    }

    inorder(root);

    let minDiff = Infinity;
    for (let i = 1; i < values.length; i++) {
        minDiff = Math.min(minDiff, values[i] - values[i - 1]);
    }

    return minDiff;
};