var minCost = function(nums, cost) {
    let minVal = nums[0];
    let maxVal = nums[0];

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] < minVal) {
            minVal = nums[i];
        }
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    const calculateTotalCost = (target) => {
        let currentTotalCost = 0n;
        for (let i = 0; i < nums.length; i++) {
            const diff = BigInt(Math.abs(nums[i] - target));
            currentTotalCost += diff * BigInt(cost[i]);
        }
        return currentTotalCost;
    };

    let low = minVal;
    let high = maxVal;

    while (low + 2 < high) {
        const mid1 = low + Math.floor((high - low) / 3);
        const mid2 = high - Math.floor((high - low) / 3);

        const cost1 = calculateTotalCost(mid1);
        const cost2 = calculateTotalCost(mid2);

        if (cost1 < cost2) {
            high = mid2;
        } else {
            low = mid1;
        }
    }

    let finalMinCost = calculateTotalCost(low);

    for (let i = low + 1; i <= high; i++) {
        const currentCost = calculateTotalCost(i);
        if (currentCost < finalMinCost) {
            finalMinCost = currentCost;
        }
    }

    return finalMinCost;
};