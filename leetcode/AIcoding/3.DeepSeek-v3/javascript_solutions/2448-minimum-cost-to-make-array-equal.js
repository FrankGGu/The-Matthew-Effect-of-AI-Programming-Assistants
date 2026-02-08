var minCost = function(nums, cost) {
    const n = nums.length;
    let arr = [];
    for (let i = 0; i < n; i++) {
        arr.push([nums[i], cost[i]]);
    }
    arr.sort((a, b) => a[0] - b[0]);

    let prefixCost = new Array(n).fill(0);
    prefixCost[0] = arr[0][1];
    for (let i = 1; i < n; i++) {
        prefixCost[i] = prefixCost[i - 1] + arr[i][1];
    }

    let totalCost = 0;
    for (let i = 1; i < n; i++) {
        totalCost += arr[i][1] * (arr[i][0] - arr[0][0]);
    }

    let res = totalCost;
    for (let i = 1; i < n; i++) {
        let gap = arr[i][0] - arr[i - 1][0];
        totalCost += prefixCost[i - 1] * gap;
        totalCost -= (prefixCost[n - 1] - prefixCost[i - 1]) * gap;
        res = Math.min(res, totalCost);
    }

    return res;
};