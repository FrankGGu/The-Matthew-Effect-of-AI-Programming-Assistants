function minCostToSplitArray(nums, cost) {
    const n = nums.length;
    const prefix = new Array(n).fill(0);
    const suffix = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + cost[i - 1];
    }

    for (let i = n - 2; i >= 0; i--) {
        suffix[i] = suffix[i + 1] + cost[i];
    }

    let minCost = Infinity;
    for (let i = 1; i < n; i++) {
        const left = prefix[i];
        const right = suffix[i];
        minCost = Math.min(minCost, left + right);
    }

    return minCost;
}