var minCost = function(nums, cost) {
    let minNum = nums[0];
    let maxNum = nums[0];
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] < minNum) minNum = nums[i];
        if (nums[i] > maxNum) maxNum = nums[i];
    }

    const calculateCost = (target) => {
        let currentTotalCost = 0n;
        for (let i = 0; i < nums.length; i++) {
            currentTotalCost += BigInt(Math.abs(nums[i] - target)) * BigInt(cost[i]);
        }
        return currentTotalCost;
    };

    let left = minNum;
    let right = maxNum;

    while (left < right) {
        let mid = left + Math.floor((right - left) / 2);
        let costMid = calculateCost(mid);
        let costMidPlusOne = calculateCost(mid + 1);

        if (costMid < costMidPlusOne) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return calculateCost(left);
};