var maximumANDSum = function(nums, numSlots) {
    const n = nums.length;
    const maskLimit = 1 << (2 * numSlots);
    const dp = new Array(maskLimit).fill(-Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < maskLimit; mask++) {
        if (dp[mask] === -Infinity) continue;

        let taken = 0;
        for (let i = 0; i < numSlots; i++) {
            const count = (mask >> (2 * i)) & 3;
            taken += count;
        }

        if (taken >= n) continue;

        const num = nums[taken];

        for (let slot = 1; slot <= numSlots; slot++) {
            const shift = 2 * (slot - 1);
            const count = (mask >> shift) & 3;
            if (count < 2) {
                const newMask = mask + (1 << shift);
                const and = num & slot;
                if (dp[newMask] < dp[mask] + and) {
                    dp[newMask] = dp[mask] + and;
                }
            }
        }
    }

    return Math.max(...dp);
};