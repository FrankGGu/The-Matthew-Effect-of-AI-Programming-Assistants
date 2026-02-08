var maxProduct = function(root) {
    let totalSum = 0;
    let maxProd = 0;

    const calculateTotalSum = (node) => {
        if (!node) return 0;
        return node.val + calculateTotalSum(node.left) + calculateTotalSum(node.right);
    };

    const calculateMaxProduct = (node) => {
        if (!node) return 0;
        const leftSum = calculateMaxProduct(node.left);
        const rightSum = calculateMaxProduct(node.right);
        const currentSum = node.val + leftSum + rightSum;
        const otherPart = totalSum - currentSum;
        maxProd = Math.max(maxProd, currentSum * otherPart);
        return currentSum;
    };

    totalSum = calculateTotalSum(root);
    calculateMaxProduct(root);
    return maxProd % (10**9 + 7);
};