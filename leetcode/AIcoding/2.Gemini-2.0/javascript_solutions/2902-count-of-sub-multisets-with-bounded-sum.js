var countSubMultisets = function(nums, l, r) {
    const MOD = 10 ** 9 + 7;
    let zeroCount = 0;
    const counts = new Map();
    for (const num of nums) {
        if (num === 0) {
            zeroCount++;
        } else {
            counts.set(num, (counts.get(num) || 0) + 1);
        }
    }

    const dpLength = r + 1;
    let dp = new Array(dpLength).fill(0);
    dp[0] = 1;

    for (const [num, count] of counts) {
        const newDp = new Array(dpLength).fill(0);
        for (let i = 0; i < dpLength; i++) {
            newDp[i] = dp[i];
        }
        for (let i = 1; i <= count; i++) {
            for (let j = num * i; j < dpLength; j++) {
                newDp[j] = (newDp[j] + dp[j - num * i]) % MOD;
            }
        }
        dp = newDp;
    }

    let ans = 0;
    for (let i = l; i <= r; i++) {
        ans = (ans + dp[i]) % MOD;
    }

    ans = (ans * (zeroCount + 1)) % MOD;

    return ans;
};