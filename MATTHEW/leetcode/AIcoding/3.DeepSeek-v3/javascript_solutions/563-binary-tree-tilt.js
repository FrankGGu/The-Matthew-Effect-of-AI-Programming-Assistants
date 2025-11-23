var findTilt = function(root) {
    let totalTilt = 0;

    const sum = (node) => {
        if (!node) return 0;
        const leftSum = sum(node.left);
        const rightSum = sum(node.right);
        const tilt = Math.abs(leftSum - rightSum);
        totalTilt += tilt;
        return node.val + leftSum + rightSum;
    };

    sum(root);
    return totalTilt;
};