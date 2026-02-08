var minimumDeletions = function(nums) {
    const n = nums.length;

    let minVal = nums[0];
    let maxVal = nums[0];
    let minIndex = 0;
    let maxIndex = 0;

    for (let i = 0; i < n; i++) {
        if (nums[i] < minVal) {
            minVal = nums[i];
            minIndex = i;
        }
        if (nums[i] > maxVal) {
            maxVal = nums[i];
            maxIndex = i;
        }
    }

    // Determine which of minIndex and maxIndex is closer to the left end (0)
    // and which is closer to the right end (n-1).
    const leftMostIndex = Math.min(minIndex, maxIndex);
    const rightMostIndex = Math.max(minIndex, maxIndex);

    // Option 1: Remove both from the left side.
    // We need to remove all elements from index 0 up to rightMostIndex (inclusive).
    // Number of deletions = rightMostIndex + 1.
    const deletionsFromLeft = rightMostIndex + 1;

    // Option 2: Remove both from the right side.
    // We need to remove all elements from leftMostIndex (inclusive) up to n-1.
    // Number of deletions = n - leftMostIndex.
    const deletionsFromRight = n - leftMostIndex;

    // Option 3: Remove one from the left and one from the right.
    // Remove elements from index 0 up to leftMostIndex (inclusive).
    // Count = leftMostIndex + 1.
    // Remove elements from rightMostIndex (inclusive) up to n-1.
    // Count = n - rightMostIndex.
    // Total deletions = (leftMostIndex + 1) + (n - rightMostIndex).
    const deletionsFromBothEnds = (leftMostIndex + 1) + (n - rightMostIndex);

    return Math.min(deletionsFromLeft, deletionsFromRight, deletionsFromBothEnds);
};