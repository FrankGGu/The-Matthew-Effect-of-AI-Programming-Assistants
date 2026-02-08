var canPartition = function(nums) {
    const n = nums.length;
    if (n <= 1) return false;

    let product = 1;
    for (const num of nums) {
        if (num === 0) continue;
        product *= num;
    }

    if (product === 0) return true;

    const target = Math.sqrt(product);
    if (target !== Math.floor(target)) return false;

    const dp = new Set();
    dp.add(1);

    for (const num of nums) {
        if (num === 0) continue;
        const newDp = new Set(dp);
        for (const val of dp) {
            newDp.add(val * num);
        }
        dp.clear();
        for (const val of newDp) {
            dp.add(val);
        }
    }

    return dp.has(target);
};