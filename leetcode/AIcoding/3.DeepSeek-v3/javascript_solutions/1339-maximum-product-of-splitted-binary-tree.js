var maxProduct = function(root) {
    const MOD = 1e9 + 7;
    let totalSum = 0;
    let maxProd = 0;

    const calculateSum = (node) => {
        if (!node) return 0;
        let sum = node.val + calculateSum(node.left) + calculateSum(node.right);
        return sum;
    };

    totalSum = calculateSum(root);

    const findMaxProduct = (node) => {
        if (!node) return 0;
        let left = findMaxProduct(node.left);
        let right = findMaxProduct(node.right);
        let subtreeSum = node.val + left + right;
        maxProd = Math.max(maxProd, subtreeSum * (totalSum - subtreeSum));
        return subtreeSum;
    };

    findMaxProduct(root);

    return maxProd % MOD;
};