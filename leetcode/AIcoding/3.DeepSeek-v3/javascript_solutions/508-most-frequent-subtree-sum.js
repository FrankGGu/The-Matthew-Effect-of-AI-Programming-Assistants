var findFrequentTreeSum = function(root) {
    const sumCount = {};
    let maxCount = 0;
    const result = [];

    function calculateSum(node) {
        if (!node) return 0;
        const leftSum = calculateSum(node.left);
        const rightSum = calculateSum(node.right);
        const currentSum = node.val + leftSum + rightSum;
        sumCount[currentSum] = (sumCount[currentSum] || 0) + 1;
        if (sumCount[currentSum] > maxCount) {
            maxCount = sumCount[currentSum];
        }
        return currentSum;
    }

    calculateSum(root);

    for (const sum in sumCount) {
        if (sumCount[sum] === maxCount) {
            result.push(parseInt(sum));
        }
    }

    return result;
};