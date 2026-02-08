var maxProduct = function(root) {
    const MOD = 1000000007n;
    const allSubtreeSums = [];

    function dfs(node) {
        if (!node) {
            return 0n;
        }

        const leftSum = dfs(node.left);
        const rightSum = dfs(node.right);

        const currentSubtreeSum = BigInt(node.val) + leftSum + rightSum;
        allSubtreeSums.push(currentSubtreeSum);
        return currentSubtreeSum;
    }

    dfs(root);

    const totalSum = allSubtreeSums[allSubtreeSums.length - 1];
    let maxProd = 0n;

    for (const s of allSubtreeSums) {
        const prod = s * (totalSum - s);
        if (prod > maxProd) {
            maxProd = prod;
        }
    }

    return Number(maxProd % MOD);
};