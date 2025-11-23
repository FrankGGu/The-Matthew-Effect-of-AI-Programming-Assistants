var minCost = function(nums, cost) {
    const n = nums.length;
    let left = Math.min(...nums);
    let right = Math.max(...nums);

    const calculateCost = (target) => {
        let totalCost = 0;
        for (let i = 0; i < n; i++) {
            totalCost += Math.abs(nums[i] - target) * cost[i];
        }
        return totalCost;
    };

    let result = Infinity;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const costMid = calculateCost(mid);
        const costMidPlusOne = calculateCost(mid + 1);

        result = Math.min(result, costMid);

        if (costMid < costMidPlusOne) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return result;
};