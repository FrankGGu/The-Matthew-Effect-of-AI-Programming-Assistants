var canDistribute = function(nums, quantity) {
    const counts = {};
    for (const num of nums) {
        counts[num] = (counts[num] || 0) + 1;
    }

    const freq = Object.values(counts).sort((a, b) => b - a);
    quantity.sort((a, b) => b - a);

    const n = freq.length;
    const m = quantity.length;
    const dp = Array(1 << m).fill(false);
    dp[0] = true;

    for (let i = 0; i < n; i++) {
        for (let mask = (1 << m) - 1; mask >= 0; mask--) {
            if (dp[mask]) {
                for (let submask = 1; submask < (1 << m); submask++) {
                    if ((mask & submask) === 0) {
                        let sum = 0;
                        let valid = true;
                        for (let j = 0; j < m; j++) {
                            if ((submask >> j) & 1) {
                                sum += quantity[j];
                            }
                        }

                        if (sum <= freq[i]) {
                            dp[mask | submask] = true;
                        }
                    }
                }
            }
        }
    }

    return dp[(1 << m) - 1];
};