var minChanges = function(nums, k) {
    const n = nums.length;
    const MAX_XOR = 1024; // Max possible XOR sum is 2^10 - 1 = 1023, since nums[i] <= 1000

    const freqs = Array(k).fill(0).map(() => new Map());
    const groupSizes = Array(k).fill(0);

    for (let i = 0; i < n; i++) {
        const groupIdx = i % k;
        const val = nums[i];
        freqs[groupIdx].set(val, (freqs[groupIdx].get(val) || 0) + 1);
        groupSizes[groupIdx]++;
    }

    let dp = Array(MAX_XOR).fill(Infinity);
    dp[0] = 0;

    for (let j = 0; j < k; j++) {
        const currentGroupFreq = freqs[j];
        const currentGroupSize = groupSizes[j];
        let newDp = Array(MAX_XOR).fill(Infinity);

        let minPrevDpVal = Infinity;
        for (let xorVal = 0; xorVal < MAX_XOR; xorVal++) {
            minPrevDpVal = Math.min(minPrevDpVal, dp[xorVal]);
        }

        for (let targetXor = 0; targetXor < MAX_XOR; targetXor++) {
            newDp[targetXor] = minPrevDpVal + currentGroupSize;

            for (const [val_x, count_of_val_x] of currentGroupFreq.entries()) {
                const prevXor = targetXor ^ val_x;
                if (dp[prevXor] !== Infinity) {
                    newDp[targetXor] = Math.min(
                        newDp[targetXor],
                        dp[prevXor] + currentGroupSize - count_of_val_x
                    );
                }
            }
        }
        dp = newDp;
    }

    return dp[0];
};