var maxSubarraySumCircular = function(nums) {
    let totalSum = 0;
    let maxSoFar = nums[0];
    let currentMax = nums[0];
    let minSoFar = nums[0];
    let currentMin = nums[0];

    totalSum += nums[0];

    for (let i = 1; i < nums.length; i++) {
        totalSum += nums[i];

        currentMax = Math.max(nums[i], currentMax + nums[i]);
        maxSoFar = Math.max(maxSoFar, currentMax);

        currentMin = Math.min(nums[i], currentMin + nums[i]);
        minSoFar = Math.min(minSoFar, currentMin);
    }

    if (maxSoFar < 0) {
        return maxSoFar;
    } else {
        return Math.max(maxSoFar, totalSum - minSoFar);
    }
};