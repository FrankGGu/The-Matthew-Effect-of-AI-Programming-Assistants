var maximumANDSum = function(nums, numSlots) {
    const n = nums.length;
    const maxMask = 1 << (2 * numSlots);
    const dp = new Array(maxMask).fill(-Infinity);

    dp[0] = 0;

    let maxAndSum = 0;

    for (let mask = 0; mask < maxMask; mask++) {
        if (dp[mask] === -Infinity) {
            continue;
        }

        let placedCount = 0;
        for (let j = 0; j < numSlots; j++) {
            const slotState = (mask >> (j * 2)) & 0b11;
            if (slotState === 0b01) {
                placedCount += 1;
            } else if (slotState === 0b10) {
                placedCount += 2;
            }
        }

        if (placedCount === n) {
            maxAndSum = Math.max(maxAndSum, dp[mask]);
            continue;
        }

        const currentNum = nums[placedCount];

        for (let j = 0; j < numSlots; j++) {
            const slotState = (mask >> (j * 2)) & 0b11;

            if (slotState < 0b10) {
                let nextMask;
                if (slotState === 0b00) {
                    nextMask = mask | (0b01 << (j * 2));
                } else {
                    nextMask = (mask & ~(0b01 << (j * 2))) | (0b10 << (j * 2));
                }

                dp[nextMask] = Math.max(dp[nextMask], dp[mask] + (currentNum & (j + 1)));
            }
        }
    }

    return maxAndSum;
};