var findXorSum = function(nums, k) {
    const n = nums.length;
    if (k <= 0 || k > n) {
        return [];
    }

    const result = [];
    let currentXorSum = 0;

    // Calculate the XOR sum for the first window
    for (let i = 0; i < k; i++) {
        currentXorSum ^= nums[i];
    }
    result.push(currentXorSum);

    // Use a sliding window to calculate XOR sums for subsequent windows
    for (let i = k; i < n; i++) {
        // Remove the element leaving the window (nums[i-k])
        // Add the new element entering the window (nums[i])
        currentXorSum ^= nums[i - k];
        currentXorSum ^= nums[i];
        result.push(currentXorSum);
    }

    return result;
};