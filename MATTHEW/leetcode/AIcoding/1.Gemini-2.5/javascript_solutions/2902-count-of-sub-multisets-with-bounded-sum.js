var countSubMultisets = function(nums, lower, upper) {
    const MOD = 10 ** 9 + 7;

    const freq = new Map();
    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    const dp = new Array(upper + 1).fill(0);
    dp[0] = 1;

    for (const [num, count] of freq.entries()) {
        if (num === 0) {
            continue;
        }

        let currentCount = count;
        let k = 1;
        while (currentCount > 0) {
            const take = Math.min(k, currentCount);
            const currentVal = num * take;

            for (let s = upper; s >= currentVal; s--) {
                dp[s] = (dp[s] + dp[s - currentVal]) % MOD;
            }

            currentCount -= take;
            k *= 2;
        }
    }

    const zeroCount = freq.get(0) || 0;
    for (let s = 0; s <= upper; s++) {
        dp[s] = (dp[s] * (zeroCount + 1)) % MOD;
    }

    let ans = 0;
    for (let s = lower; s <= upper; s++) {
        ans = (ans + dp[s]) % MOD;
    }

    return ans;
};