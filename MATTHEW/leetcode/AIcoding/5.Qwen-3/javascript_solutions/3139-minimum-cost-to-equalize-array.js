function minCostToEqualizeArray(nums, cost) {
    const n = nums.length;
    const arr = [];
    for (let i = 0; i < n; i++) {
        arr.push([nums[i], cost[i]]);
    }
    arr.sort((a, b) => a[0] - b[0]);

    const prefixSum = new Array(n).fill(0);
    const suffixSum = new Array(n).fill(0);

    prefixSum[0] = arr[0][1];
    for (let i = 1; i < n; i++) {
        prefixSum[i] = prefixSum[i - 1] + arr[i][1];
    }

    suffixSum[n - 1] = arr[n - 1][1];
    for (let i = n - 2; i >= 0; i--) {
        suffixSum[i] = suffixSum[i + 1] + arr[i][1];
    }

    let totalCost = 0;
    for (let i = 0; i < n; i++) {
        totalCost += arr[i][1];
    }

    let minCost = Infinity;
    for (let i = 0; i < n; i++) {
        const leftCost = (arr[i][0] - arr[0][0]) * prefixSum[i];
        const rightCost = (arr[n - 1][0] - arr[i][0]) * suffixSum[i];
        minCost = Math.min(minCost, leftCost + rightCost);
    }

    return minCost;
}