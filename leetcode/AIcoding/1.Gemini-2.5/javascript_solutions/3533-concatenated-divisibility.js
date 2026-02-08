var concatenatedDivisibility = function(nums, k) {
    const n = nums.length;
    const dp = Array(1 << n).fill(0).map(() => Array(k).fill(false));

    dp[0][0] = true;

    const powersOf10ModK = new Array(n);
    for (let i = 0; i < n; i++) {
        let len = String(nums[i]).length;
        let p = 1;
        for (let j = 0; j < len; j++) {
            p = (p * 10) % k;
        }
        powersOf10ModK[i] = p;
    }

    for (let mask = 0; mask < (1 << n); mask++) {
        for (let remainder = 0; remainder < k; remainder++) {
            if (dp[mask][remainder]) {
                for (let i = 0; i < n; i++) {
                    if (!((mask >> i) & 1)) {
                        const nextMask = mask | (1 << i);
                        const numVal = nums[i];
                        const power = powersOf10ModK[i];

                        const newRemainder = (remainder * power + numVal) % k;
                        dp[nextMask][newRemainder] = true;
                    }
                }
            }
        }
    }

    return dp[(1 << n) - 1][0];
};