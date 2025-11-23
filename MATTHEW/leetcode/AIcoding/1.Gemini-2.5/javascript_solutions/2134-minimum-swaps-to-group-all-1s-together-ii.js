var minSwaps = function(nums) {
    const n = nums.length;
    let totalOnes = 0;
    for (let i = 0; i < n; i++) {
        totalOnes += nums[i];
    }

    if (totalOnes <= 1) {
        return 0;
    }

    let currentOnesInWindow = 0;
    // Calculate ones in the initial window
    for (let i = 0; i < totalOnes; i++) {
        currentOnesInWindow += nums[i];
    }

    let maxOnesInWindow = currentOnesInWindow;

    // Slide the window across the circular array
    for (let i = 1; i < n; i++) {
        // Remove the element leaving the window
        currentOnesInWindow -= nums[i - 1];
        // Add the element entering the window (circularly)
        currentOnesInWindow += nums[(i + totalOnes - 1) % n];

        maxOnesInWindow = Math.max(maxOnesInWindow, currentOnesInWindow);
    }

    return totalOnes - maxOnesInWindow;
};