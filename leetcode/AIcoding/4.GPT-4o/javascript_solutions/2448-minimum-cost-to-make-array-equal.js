var minCost = function(nums, cost) {
    const n = nums.length;
    const totalCost = (target) => {
        let total = 0;
        for (let i = 0; i < n; i++) {
            total += Math.abs(nums[i] - target) * cost[i];
        }
        return total;
    };

    let left = Math.min(...nums), right = Math.max(...nums);
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        const midCost = totalCost(mid);
        const midPlusCost = totalCost(mid + 1);
        if (midCost < midPlusCost) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return totalCost(left);
};