var maxRotateFunction = function(nums) {
    let sum = 0;
    let f0 = 0;
    let n = nums.length;
    for (let i = 0; i < n; i++) {
        sum += nums[i];
        f0 += i * nums[i];
    }
    let max = f0;
    for (let i = 1; i < n; i++) {
        f0 = f0 + sum - n * nums[n - i];
        max = Math.max(max, f0);
    }
    return max;
};