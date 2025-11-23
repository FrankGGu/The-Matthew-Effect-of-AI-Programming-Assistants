var maxAbsoluteSum = function(nums) {
    let maxSoFar = 0;
    let minSoFar = 0;
    let currentMax = 0;
    let currentMin = 0;

    for (let i = 0; i < nums.length; i++) {
        currentMax = Math.max(nums[i], currentMax + nums[i]);
        maxSoFar = Math.max(maxSoFar, currentMax);

        currentMin = Math.min(nums[i], currentMin + nums[i]);
        minSoFar = Math.min(minSoFar, currentMin);
    }

    return Math.max(Math.abs(maxSoFar), Math.abs(minSoFar));
};