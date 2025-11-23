var findTilt = function(root) {
    let tilt = 0;

    function sumAndTilt(node) {
        if (!node) return 0;

        let leftSum = sumAndTilt(node.left);
        let rightSum = sumAndTilt(node.right);

        tilt += Math.abs(leftSum - rightSum);

        return node.val + leftSum + rightSum;
    }

    sumAndTilt(root);
    return tilt;
};