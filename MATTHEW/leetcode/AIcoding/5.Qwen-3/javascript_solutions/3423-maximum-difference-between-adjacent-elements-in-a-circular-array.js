function maxAdjacentDifference(nums) {
    if (nums.length < 2) return 0;

    let minVal = nums[0];
    let maxVal = nums[0];

    for (let i = 1; i < nums.length; i++) {
        minVal = Math.min(minVal, nums[i]);
        maxVal = Math.max(maxVal, nums[i]);
    }

    let maxDiff = 0;

    for (let i = 1; i < nums.length; i++) {
        maxDiff = Math.max(maxDiff, Math.abs(nums[i] - nums[i - 1]));
    }

    maxDiff = Math.max(maxDiff, Math.abs(nums[0] - nums[nums.length - 1]));

    return maxDiff;
}