var maxSubarraySumCircular = function(nums) {
    let totalSum = 0;
    let maxSoFar = nums[0];
    let currentMax = 0;
    let minSoFar = nums[0];
    let currentMin = 0;

    for (let i = 0; i < nums.length; i++) {
        totalSum += nums[i];

        currentMax += nums[i];
        maxSoFar = Math.max(maxSoFar, currentMax);
        if (currentMax < 0) {
            currentMax = 0;
        }

        currentMin += nums[i];
        minSoFar = Math.min(minSoFar, currentMin);
        if (currentMin > 0) {
            currentMin = 0;
        }
    }

    if (maxSoFar > 0) {
        return Math.max(maxSoFar, totalSum - minSoFar);
    } else {
        return maxSoFar;
    }
};