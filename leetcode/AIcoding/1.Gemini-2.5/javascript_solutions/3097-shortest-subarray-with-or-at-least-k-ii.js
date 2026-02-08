var shortestSubarrayWithORAtLeastK = function(nums, k) {
    const N = nums.length;
    let minLen = Infinity;
    let l = 0;
    let currentOR = 0;
    // bitCounts[j] stores the number of elements in the current window [l, r] that have the j-th bit set.
    // Max value for nums[i] and k is 10^9, which fits in 30 bits (0 to 29).
    const bitCounts = new Array(30).fill(0);

    for (let r = 0; r < N; r++) {
        // Add nums[r] to the window
        for (let j = 0; j < 30; j++) {
            if ((nums[r] >> j) & 1) {
                bitCounts[j]++;
                // If this is the first element in the window to set this bit, update currentOR
                if (bitCounts[j] === 1) {
                    currentOR |= (1 << j);
                }
            }
        }

        // While currentOR is at least k, try to shrink the window from the left
        while (currentOR >= k) {
            minLen = Math.min(minLen, r - l + 1);

            // Remove nums[l] from the window
            for (let j = 0; j < 30; j++) {
                if ((nums[l] >> j) & 1) {
                    bitCounts[j]--;
                    // If no more elements in the window set this bit, clear it from currentOR
                    if (bitCounts[j] === 0) {
                        currentOR &= ~(1 << j);
                    }
                }
            }
            l++;
        }
    }

    return minLen === Infinity ? -1 : minLen;
};