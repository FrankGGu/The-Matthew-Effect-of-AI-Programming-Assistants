var minDiffInBST = function(root) {
    let minDiff = Infinity;
    let prevVal = null;

    function inorderTraversal(node) {
        if (!node) {
            return;
        }

        inorderTraversal(node.left);

        if (prevVal !== null) {
            minDiff = Math.min(minDiff, node.val - prevVal);
        }
        prevVal = node.val;

        inorderTraversal(node.right);
    }

    inorderTraversal(root);
    return minDiff;
};