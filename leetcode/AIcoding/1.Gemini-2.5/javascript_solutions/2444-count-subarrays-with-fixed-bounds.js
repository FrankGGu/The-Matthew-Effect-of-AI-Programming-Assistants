var countSubarrays = function(nums, minK, maxK) {
    let ans = 0;
    let leftBound = -1; // Index of the last element that was out of [minK, maxK] range
    let lastMinK = -1;  // Index of the last occurrence of minK
    let lastMaxK = -1;  // Index of the last occurrence of maxK

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] < minK || nums[i] > maxK) {
            // Current element is out of bounds, so any fixed-bound subarray cannot cross this point.
            // Reset the window.
            leftBound = i;
            // lastMinK and lastMaxK are not explicitly reset to -1,
            // as their values being less than leftBound will naturally make the count 0 or negative.
        }

        if (nums[i] === minK) {
            lastMinK = i;
        }

        if (nums[i] === maxK) {
            lastMaxK = i;
        }

        // A valid subarray ending at 'i' must have its starting point 'j'
        // such that j > leftBound, j <= lastMinK, and j <= lastMaxK.
        // The number of such 'j' values is min(lastMinK, lastMaxK) - leftBound.
        // We take max(0, ...) to handle cases where minK or maxK haven't appeared yet
        // or are before the current leftBound.
        ans += Math.max(0, Math.min(lastMinK, lastMaxK) - leftBound);
    }

    return ans;
};