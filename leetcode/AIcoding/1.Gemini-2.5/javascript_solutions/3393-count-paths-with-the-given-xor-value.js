var countPathsWithGivenXOR = function(nums, k) {
    let count = 0;
    let currentXOR = 0;
    const xorCounts = new Map();
    xorCounts.set(0, 1);

    for (let i = 0; i < nums.length; i++) {
        currentXOR ^= nums[i];

        if (xorCounts.has(currentXOR ^ k)) {
            count += xorCounts.get(currentXOR ^ k);
        }

        xorCounts.set(currentXOR, (xorCounts.get(currentXOR) || 0) + 1);
    }

    return count;
};