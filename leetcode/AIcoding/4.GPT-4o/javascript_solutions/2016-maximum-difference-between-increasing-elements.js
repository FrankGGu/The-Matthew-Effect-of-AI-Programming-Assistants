var maximumDifference = function(nums) {
    let maxDiff = -1;
    let minElement = nums[0];

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] > minElement) {
            maxDiff = Math.max(maxDiff, nums[i] - minElement);
        } else {
            minElement = nums[i];
        }
    }

    return maxDiff;
};