var waysToSplitArray = function(nums) {
    const n = nums.length;
    const prefixSums = new Array(n + 1).fill(0);

    for (let k = 0; k < n; k++) {
        prefixSums[k + 1] = prefixSums[k] + nums[k];
    }

    let count = 0;

    // i is the last index of the left subarray.
    // The left subarray is nums[0...i].
    // The mid subarray is nums[i+1...j].
    // The right subarray is nums[j+1...n-1].

    // Conditions for indices:
    // 1. left subarray must be non-empty: i >= 0.
    // 2. mid subarray must be non-empty: i + 1 <= j.
    // 3. right subarray must be non-empty: j + 1 <= n - 1, which means j <= n - 2.

    // Combining these, we get:
    // i must be at least 0.
    // j must be at least i + 1.
    // j must be at most n - 2.
    // From j >= i + 1 and j <= n - 2, it implies i + 1 <= n - 2, so i <= n - 3.
    // Thus, i ranges from 0 to n - 3.

    for (let i = 0; i <= n - 3; i++) {
        const sumLeft = prefixSums[i + 1];

        // j ranges from i + 1 to n - 2.
        for (let j = i + 1; j <= n - 2; j++) {
            const sumMid = prefixSums[j + 1] - prefixSums[i + 1];
            const sumRight = prefixSums[n] - prefixSums[j + 1];

            if (sumLeft >= sumMid && sumMid >= sumRight) {
                count++;
            }
        }
    }

    return count;
};