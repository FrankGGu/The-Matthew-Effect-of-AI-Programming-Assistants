var minCost = function(costs) {
    let totalCostIncrease = 0;
    const n = costs.length;

    function dfs(index) {
        if (index >= n) {
            return 0;
        }

        const leftChildPathSum = dfs(2 * index + 1);
        const rightChildPathSum = dfs(2 * index + 2);

        totalCostIncrease += Math.abs(leftChildPathSum - rightChildPathSum);

        return costs[index] + Math.max(leftChildPathSum, rightChildPathSum);
    }

    dfs(0);
    return totalCostIncrease;
};