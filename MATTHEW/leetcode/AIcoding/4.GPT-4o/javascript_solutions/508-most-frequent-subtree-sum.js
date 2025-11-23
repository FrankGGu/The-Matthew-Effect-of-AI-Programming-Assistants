var findFrequentTreeSum = function(root) {
    const count = new Map();
    let maxFreq = 0;

    const postOrder = (node) => {
        if (!node) return 0;
        const leftSum = postOrder(node.left);
        const rightSum = postOrder(node.right);
        const sum = leftSum + rightSum + node.val;
        count.set(sum, (count.get(sum) || 0) + 1);
        maxFreq = Math.max(maxFreq, count.get(sum));
        return sum;
    };

    postOrder(root);
    return [...count.entries()].filter(([_, freq]) => freq === maxFreq).map(([sum]) => sum);
};