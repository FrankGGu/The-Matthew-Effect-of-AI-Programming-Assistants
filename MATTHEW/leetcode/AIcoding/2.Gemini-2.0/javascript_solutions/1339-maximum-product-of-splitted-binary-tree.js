var maxProduct = function(root) {
    let totalSum = 0;
    let sums = [];

    function calculateSum(node) {
        if (!node) return 0;

        let leftSum = calculateSum(node.left);
        let rightSum = calculateSum(node.right);

        let currentSum = node.val + leftSum + rightSum;
        sums.push(currentSum);
        return currentSum;
    }

    totalSum = calculateSum(root);

    let maxProduct = 0;
    for (let sum of sums) {
        maxProduct = Math.max(maxProduct, (totalSum - sum) * sum);
    }

    return maxProduct % (10**9 + 7);
};