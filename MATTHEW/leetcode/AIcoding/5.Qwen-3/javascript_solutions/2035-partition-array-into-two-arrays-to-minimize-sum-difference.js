function minimumDifference(nums) {
    const total = nums.reduce((sum, num) => sum + num, 0);
    const n = nums.length;
    const target = Math.floor(total / 2);
    const dp = new Set([0]);

    for (const num of nums) {
        const next = new Set(dp);
        for (const val of dp) {
            next.add(val + num);
        }
        dp.clear();
        for (const val of next) {
            dp.add(val);
        }
    }

    let minDiff = Infinity;
    for (const val of dp) {
        if (Math.abs(total - 2 * val) < minDiff) {
            minDiff = Math.abs(total - 2 * val);
        }
    }

    return minDiff;
}