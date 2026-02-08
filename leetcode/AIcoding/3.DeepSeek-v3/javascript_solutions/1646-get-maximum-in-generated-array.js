var getMaximumGenerated = function(n) {
    if (n === 0) return 0;
    const nums = new Array(n + 1).fill(0);
    nums[1] = 1;
    let max = 1;
    for (let i = 2; i <= n; i++) {
        if (i % 2 === 0) {
            nums[i] = nums[i / 2];
        } else {
            nums[i] = nums[Math.floor(i / 2)] + nums[Math.floor(i / 2) + 1];
        }
        max = Math.max(max, nums[i]);
    }
    return max;
};