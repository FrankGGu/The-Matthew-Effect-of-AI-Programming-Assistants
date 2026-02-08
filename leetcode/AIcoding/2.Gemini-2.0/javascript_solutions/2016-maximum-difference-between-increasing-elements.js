var maximumDifference = function(nums) {
    let maxDiff = -1;
    let minVal = nums[0];
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] > minVal) {
            maxDiff = Math.max(maxDiff, nums[i] - minVal);
        } else {
            minVal = nums[i];
        }
    }
    return maxDiff;
};