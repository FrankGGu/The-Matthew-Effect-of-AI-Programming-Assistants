var maxPathSum = function(root) {
    let maxSum = -Infinity;

    function maxGain(node) {
        if (!node) {
            return 0;
        }

        const leftGain = Math.max(maxGain(node.left), 0);
        const rightGain = Math.max(maxGain(node.right), 0);

        const priceNewPath = node.val + leftGain + rightGain;

        maxSum = Math.max(maxSum, priceNewPath);

        return node.val + Math.max(leftGain, rightGain);
    }

    maxGain(root);
    return maxSum;
};