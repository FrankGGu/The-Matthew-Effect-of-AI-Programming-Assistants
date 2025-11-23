var maxRotateFunction = function(nums) {
    const n = nums.length;
    let sum = 0;
    let f = 0;
    for (let i = 0; i < n; i++) {
        sum += nums[i];
        f += i * nums[i];
    }
    let max = f;
    for (let i = n - 1; i >= 1; i--) {
        f = f + sum - n * nums[i];
        if (f > max) {
            max = f;
        }
    }
    return max;
};