var getMaximumGenerated = function(n) {
    if (n === 0) return 0;
    if (n === 1) return 1;

    const nums = new Array(n + 1).fill(0);
    nums[0] = 0;
    nums[1] = 1;

    let max = 1;
    for (let i = 2; i <= n; i++) {
        nums[i] = i % 2 === 0 ? nums[i / 2] : nums[Math.floor(i / 2)] + nums[Math.floor(i / 2) + 1];
        max = Math.max(max, nums[i]);
    }

    return max;
};