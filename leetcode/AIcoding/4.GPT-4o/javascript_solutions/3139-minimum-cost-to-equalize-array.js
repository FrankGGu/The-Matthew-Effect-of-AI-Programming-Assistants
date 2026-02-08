var minCost = function(nums, cost) {
    const n = nums.length;
    let left = Math.min(...nums), right = Math.max(...nums);

    const calculateCost = (target) => {
        let totalCost = 0;
        for (let i = 0; i < n; i++) {
            totalCost += Math.abs(nums[i] - target) * cost[i];
        }
        return totalCost;
    };

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        const costMid = calculateCost(mid);
        const costMidPlusOne = calculateCost(mid + 1);

        if (costMid < costMidPlusOne) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return calculateCost(left);
};