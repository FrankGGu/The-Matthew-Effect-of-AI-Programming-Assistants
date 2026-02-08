function findMinimumCost(nums, cost) {
    const n = nums.length;
    let left = Math.min(...nums), right = Math.max(...nums);

    const calculateCost = (x) => {
        let totalCost = 0;
        for (let i = 0; i < n; i++) {
            totalCost += Math.abs(nums[i] - x) * cost[i];
        }
        return totalCost;
    };

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        const cost1 = calculateCost(mid);
        const cost2 = calculateCost(mid + 1);

        if (cost1 < cost2) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return calculateCost(left);
}