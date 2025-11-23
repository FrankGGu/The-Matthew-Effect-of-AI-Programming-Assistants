var partitionDisjoint = function(nums) {
    let leftMax = nums[0];
    let overallMax = nums[0];
    let partitionIndex = 0;

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] < leftMax) {
            partitionIndex = i;
            leftMax = overallMax;
        } else {
            overallMax = Math.max(overallMax, nums[i]);
        }
    }

    return partitionIndex + 1;
};