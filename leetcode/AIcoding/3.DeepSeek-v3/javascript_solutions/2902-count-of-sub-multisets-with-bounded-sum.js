var countSubMultisets = function(nums, l, r) {
    const MOD = 1e9 + 7;
    const freq = new Map();
    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    const dp = new Array(r + 1).fill(0);
    dp[0] = 1;

    for (const [num, cnt] of freq) {
        for (let j = r; j >= 0; j--) {
            if (dp[j]) {
                for (let k = 1; k <= cnt; k++) {
                    if (j + k * num <= r) {
                        dp[j + k * num] = (dp[j + k * num] + dp[j]) % MOD;
                    }
                }
            }
        }
    }

    let res = 0;
    for (let i = l; i <= r; i++) {
        res = (res + dp[i]) % MOD;
    }

    return res;
};