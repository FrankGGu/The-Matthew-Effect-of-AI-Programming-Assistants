var largestSumAfterKNegations = function(nums, k) {
    nums.sort((a, b) => a - b);
    let i = 0;
    while (k > 0 && i < nums.length && nums[i] < 0) {
        nums[i] = -nums[i];
        k--;
        i++;
    }
    if (k % 2 === 1) {
        nums.sort((a, b) => a - b);
        nums[0] = -nums[0];
    }
    return nums.reduce((a, b) => a + b, 0);
};