var minimumMountainRemovals = function(nums) {
    const n = nums.length;
    if (n < 3) {
        return 0; // Should not happen based on constraints but good practice
    }

    const dp_inc = new Array(n).fill(1);
    const dp_dec = new Array(n).fill(1);

    // Calculate dp_inc: length of longest increasing subsequence ending at i
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                dp_inc[i] = Math.max(dp_inc[i], dp_inc[j] + 1);
            }
        }
    }

    // Calculate dp_dec: length of longest decreasing subsequence starting at i
    // (equivalent to LIS from right to left)
    for (let i = n - 1; i >= 0; i--) {
        for (let j = n - 1; j > i; j--) {
            if (nums[i] > nums[j]) {
                dp_dec[i] = Math.max(dp_dec[i], dp_dec[j] + 1);
            }
        }
    }

    let maxMountainLength = 0;

    // Find the maximum length of a mountain array
    // A mountain array must have at least one element on the increasing side
    // and at least one element on the decreasing side, besides the peak itself.
    // So, dp_inc[i] > 1 and dp_dec[i] > 1.
    for (let i = 0; i < n; i++) {
        if (dp_inc[i] > 1 && dp_dec[i] > 1) {
            maxMountainLength = Math.max(maxMountainLength, dp_inc[i] + dp_dec[i] - 1);
        }
    }

    return n - maxMountainLength;
};