var findStableMountains = function(nums) {
    const n = nums.length;
    if (n < 3) {
        return [];
    }

    // lsi[k] is true if nums[0] < nums[1] < ... < nums[k]
    const lsi = new Array(n).fill(false);
    lsi[0] = true;
    for (let i = 1; i < n; i++) {
        if (lsi[i - 1] && nums[i - 1] < nums[i]) {
            lsi[i] = true;
        }
    }

    // rsi[k] is true if nums[k] < nums[k+1] < ... < nums[n-1]
    const rsi = new Array(n).fill(false);
    rsi[n - 1] = true;
    for (let i = n - 2; i >= 0; i--) {
        if (rsi[i + 1] && nums[i] < nums[i + 1]) {
            rsi[i] = true;
        }
    }

    const result = [];
    for (let i = 1; i < n - 1; i++) {
        // Condition 1 & 2: nums[i] is a peak
        const isPeak = nums[i - 1] < nums[i] && nums[i] > nums[i + 1];

        // Condition 3: The left slope nums[i-1], nums[i-2], ..., nums[0] is strictly decreasing.
        // This is equivalent to nums[0] < nums[1] < ... < nums[i-1].
        const isLeftSlopeStable = lsi[i - 1];

        // Condition 4: The right slope nums[i+1], nums[i+2], ..., nums[n-1] is strictly increasing.
        const isRightSlopeStable = rsi[i + 1];

        if (isPeak && isLeftSlopeStable && isRightSlopeStable) {
            result.push(i);
        }
    }

    return result;
};