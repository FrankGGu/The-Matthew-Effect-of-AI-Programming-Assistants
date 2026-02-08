var concatenatedDivisible = function(nums) {
    const n = nums.length;
    const MOD = 1e9 + 7;
    let count = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i === j) continue;
            const numStr = nums[i].toString() + nums[j].toString();
            const num = parseInt(numStr, 10);
            if (num % 7 === 0) {
                count = (count + 1) % MOD;
            }
        }
    }

    return count;
};