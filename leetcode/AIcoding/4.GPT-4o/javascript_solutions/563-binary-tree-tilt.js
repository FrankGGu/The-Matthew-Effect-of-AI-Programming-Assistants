var findTilt = function(root) {
    let totalTilt = 0;

    const postOrder = (node) => {
        if (!node) return 0;
        const leftSum = postOrder(node.left);
        const rightSum = postOrder(node.right);
        totalTilt += Math.abs(leftSum - rightSum);
        return leftSum + rightSum + node.val;
    };

    postOrder(root);
    return totalTilt;
};