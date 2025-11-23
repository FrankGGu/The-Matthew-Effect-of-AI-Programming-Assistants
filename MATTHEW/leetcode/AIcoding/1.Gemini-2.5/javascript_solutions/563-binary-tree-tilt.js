var findTilt = function(root) {
    let totalTilt = 0;

    function postOrderSum(node) {
        if (!node) {
            return 0;
        }

        const leftSum = postOrderSum(node.left);
        const rightSum = postOrderSum(node.right);

        totalTilt += Math.abs(leftSum - rightSum);

        return node.val + leftSum + rightSum;
    }

    postOrderSum(root);
    return totalTilt;
};