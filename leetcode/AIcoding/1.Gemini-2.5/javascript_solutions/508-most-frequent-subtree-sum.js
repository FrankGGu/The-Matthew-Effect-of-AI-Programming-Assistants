var findFrequentTreeSum = function(root) {
    const sumCounts = new Map();
    let maxFreq = 0;

    function calculateSubtreeSum(node) {
        if (!node) {
            return 0;
        }

        const leftSum = calculateSubtreeSum(node.left);
        const rightSum = calculateSubtreeSum(node.right);
        const currentSubtreeSum = node.val + leftSum + rightSum;

        const count = (sumCounts.get(currentSubtreeSum) || 0) + 1;
        sumCounts.set(currentSubtreeSum, count);
        maxFreq = Math.max(maxFreq, count);

        return currentSubtreeSum;
    }

    calculateSubtreeSum(root);

    const result = [];
    for (const [sum, freq] of sumCounts.entries()) {
        if (freq === maxFreq) {
            result.push(sum);
        }
    }

    return result;
};