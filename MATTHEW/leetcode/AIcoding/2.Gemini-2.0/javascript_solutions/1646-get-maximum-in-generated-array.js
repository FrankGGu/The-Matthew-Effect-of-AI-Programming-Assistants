var getMaximumGenerated = function(n) {
    if (n === 0) return 0;
    if (n === 1) return 1;

    const nums = new Array(n + 1);
    nums[0] = 0;
    nums[1] = 1;
    let maxVal = 1;

    for (let i = 2; i <= n; i++) {
        if (i % 2 === 0) {
            nums[i] = nums[i / 2];
        } else {
            nums[i] = nums[Math.floor(i / 2)] + nums[Math.floor(i / 2) + 1];
        }
        maxVal = Math.max(maxVal, nums[i]);
    }

    return maxVal;
};