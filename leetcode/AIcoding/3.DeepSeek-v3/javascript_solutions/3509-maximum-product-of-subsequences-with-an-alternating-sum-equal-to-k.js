var maximumProduct = function(nums, k) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    let dp = new Map();
    dp.set(0, 1);

    for (let num of nums) {
        const newDp = new Map();
        for (let [sum, count] of dp) {
            // Not take num
            if (newDp.has(sum)) {
                newDp.set(sum, (newDp.get(sum) + count) % MOD);
            } else {
                newDp.set(sum, count % MOD);
            }
            // Take num with alternating sign
            const newSum = sum + num * (sum % 2 === 0 ? 1 : -1);
            if (newDp.has(newSum)) {
                newDp.set(newSum, (newDp.get(newSum) + count) % MOD);
            } else {
                newDp.set(newSum, count % MOD);
            }
        }
        dp = newDp;
    }

    return dp.get(k) || 0;
};