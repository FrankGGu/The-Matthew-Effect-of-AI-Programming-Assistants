function minCostToMakeElementEqual(nums, cost) {
    const n = nums.length;
    const pairs = [];
    for (let i = 0; i < n; i++) {
        pairs.push([nums[i], cost[i]]);
    }
    pairs.sort((a, b) => a[0] - b[0]);

    const prefixSum = new Array(n).fill(0);
    const suffixSum = new Array(n).fill(0);

    prefixSum[0] = pairs[0][1];
    for (let i = 1; i < n; i++) {
        prefixSum[i] = prefixSum[i - 1] + pairs[i][1];
    }

    suffixSum[n - 1] = pairs[n - 1][1];
    for (let i = n - 2; i >= 0; i--) {
        suffixSum[i] = suffixSum[i + 1] + pairs[i][1];
    }

    let totalCost = 0;
    for (let i = 0; i < n; i++) {
        totalCost += Math.abs(pairs[i][0] - pairs[0][0]) * pairs[i][1];
    }

    let minCost = totalCost;

    for (let i = 1; i < n; i++) {
        const leftCount = prefixSum[i - 1];
        const rightCount = suffixSum[i];
        const diff = pairs[i][0] - pairs[i - 1][0];
        totalCost = totalCost - diff * leftCount + diff * rightCount;
        if (totalCost < minCost) {
            minCost = totalCost;
        }
    }

    return minCost;
}