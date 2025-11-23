var getMaximumGenerated = function(n) {
    if (n === 0) {
        return 0;
    }
    if (n === 1) {
        return 1;
    }

    const nums = new Array(n + 1);
    nums[0] = 0;
    nums[1] = 1;

    let maxVal = 1;

    for (let i = 1; i <= n / 2; i++) {
        const index2i = 2 * i;
        const index2iPlus1 = 2 * i + 1;

        if (index2i <= n) {
            nums[index2i] = nums[i];
            maxVal = Math.max(maxVal, nums[index2i]);
        }

        if (index2iPlus1 <= n) {
            nums[index2iPlus1] = nums[i] + nums[i + 1];
            maxVal = Math.max(maxVal, nums[index2iPlus1]);
        }
    }

    return maxVal;
};