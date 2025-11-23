var longestGoodSegment = function(nums, k) {
    let maxLen = 0;
    let l = 0;
    // bitCounts[j] stores the count of numbers in the current window [l, r] that have the j-th bit set.
    // Numbers are up to 10^9, which fits in 30 bits (2^29 < 10^9 < 2^30).
    const bitCounts = new Array(30).fill(0);
    // currentOr stores the bitwise OR of all numbers in the current window [l, r].
    let currentOr = 0;

    for (let r = 0; r < nums.length; r++) {
        // Add nums[r] to the window
        for (let j = 0; j < 30; j++) {
            if ((nums[r] >> j) & 1) {
                bitCounts[j]++;
            }
        }

        // Recalculate currentOr based on bitCounts for the window [l, r]
        // This is necessary because currentOr cannot be simply updated with `currentOr |= nums[r]`
        // when elements are removed from the left.
        let tempOr = 0;
        for (let j = 0; j < 30; j++) {
            if (bitCounts[j] > 0) {
                tempOr |= (1 << j);
            }
        }
        currentOr = tempOr;

        // While the current window [l, r] is "good" (currentOr >= k)
        // we try to shrink the window from the left (increment l)
        // to find the smallest possible 'l' for the current 'r' that satisfies the condition.
        // This ensures that for each 'r', we consider all valid segments ending at 'r'.
        while (currentOr >= k) {
            // Update maxLen with the length of the current good segment [l, r]
            maxLen = Math.max(maxLen, r - l + 1);

            // Remove nums[l] from the window
            for (let j = 0; j < 30; j++) {
                if ((nums[l] >> j) & 1) {
                    bitCounts[j]--;
                }
            }
            l++; // Shrink the window from the left

            // Recalculate currentOr for the new window [l, r]
            // If l > r, the window is empty, and currentOr should be 0.
            if (l <= r) {
                tempOr = 0;
                for (let j = 0; j < 30; j++) {
                    if (bitCounts[j] > 0) {
                        tempOr |= (1 << j);
                    }
                }
                currentOr = tempOr;
            } else {
                currentOr = 0; // Window is empty
            }
        }
    }

    return maxLen;
};