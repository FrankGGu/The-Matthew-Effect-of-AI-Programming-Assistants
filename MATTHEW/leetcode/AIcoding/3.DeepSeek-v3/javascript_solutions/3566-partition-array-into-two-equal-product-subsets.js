var canPartition = function(nums) {
    const totalProduct = nums.reduce((a, b) => a * b, 1);
    if (totalProduct === 0) return true;
    const target = Math.sqrt(totalProduct);
    if (!Number.isInteger(target)) return false;

    const dp = new Set();
    dp.add(1);

    for (const num of nums) {
        const temp = new Set();
        for (const val of dp) {
            const product = val * num;
            if (product === target) return true;
            if (product < target) temp.add(product);
        }
        for (const val of temp) {
            dp.add(val);
        }
    }

    return false;
};