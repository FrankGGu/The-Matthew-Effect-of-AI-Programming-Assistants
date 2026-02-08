var findFrequentTreeSum = function(root) {
    const sumCounts = new Map();
    let maxCount = 0;

    function subtreeSum(node) {
        if (!node) {
            return 0;
        }

        const leftSum = subtreeSum(node.left);
        const rightSum = subtreeSum(node.right);
        const sum = node.val + leftSum + rightSum;

        const count = (sumCounts.get(sum) || 0) + 1;
        sumCounts.set(sum, count);
        maxCount = Math.max(maxCount, count);

        return sum;
    }

    subtreeSum(root);

    const result = [];
    for (const [sum, count] of sumCounts.entries()) {
        if (count === maxCount) {
            result.push(sum);
        }
    }

    return result;
};