var findXSum = function(nums, k, x) {
    let sum = 0;
    for (let i = 0; i <= nums.length - k; i++) {
        sum += nums[i + x];
    }
    return sum;
};