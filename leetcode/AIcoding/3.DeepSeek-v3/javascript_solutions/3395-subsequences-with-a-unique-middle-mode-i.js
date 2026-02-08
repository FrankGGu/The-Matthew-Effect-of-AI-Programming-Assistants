var countSubsequencesWithUniqueMiddleMode = function(nums) {
    const MOD = 1e9 + 7;
    let count = 0;
    const n = nums.length;

    for (let mask = 1; mask < (1 << n); mask++) {
        const subsequence = [];
        for (let i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                subsequence.push(nums[i]);
            }
        }
        subsequence.sort((a, b) => a - b);
        const m = subsequence.length;
        if (m % 2 === 1) {
            const mid = subsequence[Math.floor(m / 2)];
            let freq = 0;
            for (const num of subsequence) {
                if (num === mid) {
                    freq++;
                }
            }
            if (freq === 1) {
                count = (count + 1) % MOD;
            }
        }
    }

    return count;
};