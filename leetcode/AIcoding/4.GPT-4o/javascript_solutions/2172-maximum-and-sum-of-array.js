var maximumANDSum = function(nums, numSlots) {
    const dp = new Array(1 << (2 * numSlots)).fill(0);
    const n = nums.length;

    for (let mask = 0; mask < (1 << (2 * numSlots)); mask++) {
        let count = new Array(numSlots).fill(0);

        for (let j = 0; j < numSlots; j++) {
            count[j] = (mask >> (2 * j)) & 3;
        }

        for (let i = 0; i < n; i++) {
            for (let j = 0; j < numSlots; j++) {
                if (count[j] < 2) {
                    const newMask = mask | (1 << (2 * j + count[j]));
                    dp[newMask] = Math.max(dp[newMask], dp[mask] + (nums[i] & (j + 1)));
                }
            }
        }
    }

    return Math.max(...dp);
};