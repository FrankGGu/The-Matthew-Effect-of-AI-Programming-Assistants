var maxSequenceValue = function(nums) {
    if (nums.length < 2) {
        return -Infinity;
    }

    let minElementSoFar = nums[0];
    let maximumDifference = -Infinity;

    for (let j = 1; j < nums.length; j++) {
        maximumDifference = Math.max(maximumDifference, nums[j] - minElementSoFar);
        minElementSoFar = Math.min(minElementSoFar, nums[j]);
    }

    return maximumDifference;
};