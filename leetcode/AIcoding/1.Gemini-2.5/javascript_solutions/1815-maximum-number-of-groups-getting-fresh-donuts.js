var maxHappyGroups = function(batchSize, groups) {
    // counts[r] stores the number of groups that want r donuts (modulo batchSize)
    const counts = new Array(batchSize).fill(0);
    let ans = 0;

    // Step 1: Process groups and initialize counts
    for (const g of groups) {
        const r = g % batchSize;
        if (r === 0) {
            ans++; // Groups that want a multiple of batchSize always get fresh donuts
        } else {
            counts[r]++;
        }
    }

    // Step 2: Apply optimization for groups with counts[r] >= batchSize
    // If we have 'k' groups of remainder 'r' where k >= batchSize,
    // we can serve 'batchSize' of these groups. One of them will get fresh donuts.
    // Example: batchSize=3, r=1. Serve 1 (rem=2), Serve 1 (rem=1), Serve 1 (rem=0).
    // The last group served in this cycle gets fresh donuts.
    // So, we add floor(counts[r] / batchSize) to 'ans' and update counts[r] to counts[r] % batchSize.
    for (let r = 1; r < batchSize; r++) {
        ans += Math.floor(counts[r] / batchSize);
        counts[r] %= batchSize;
    }

    // Step 3: Dynamic Programming with Memoization
    // The state for DP will be (current_remainder, mask_of_counts).
    // current_remainder: The remainder of donuts in the current batch (0 means fresh batch).
    // mask_of_counts: An integer representing [counts[1], counts[2], ..., counts[batchSize-1]].
    // Each counts[r] is now between 0 and batchSize - 1.
    // We pack these counts into a single integer for efficient memoization keys.

    const memo = new Map();

    // Function to pack the counts array (from index 1 to batchSize-1) into a single integer mask.
    // We use batchSize as the base for encoding. Each count[r] is < batchSize.
    function getMask(currentCounts) {
        let mask = 0;
        let p = 1; // Power of batchSize
        for (let r = 1; r < batchSize; r++) {
            mask += currentCounts[r] * p;
            p *= batchSize;
        }
        return mask;
    }

    // Function to unpack the mask into a temporary counts array (from index 1 to batchSize-1).
    function getCountsFromMask(mask) {
        const currentCounts = new Array(batchSize).fill(0); // Fill with 0, as counts[0] is not part of mask
        let tempMask = mask;
        for (let r = 1; r < batchSize; r++) {
            currentCounts[r] = tempMask % batchSize;
            tempMask = Math.floor(tempMask / batchSize);
        }
        return currentCounts;
    }

    // dp(rem, mask) returns the maximum additional groups that can get fresh donuts
    // starting from this state.
    // rem: current remainder of donuts in the batch. 0 means fresh batch.
    // mask: packed integer representing counts[1]...counts[batchSize-1].
    function solve(rem, mask) {
        // Combine 'rem' and 'mask' into a unique key for memoization.
        // The maximum value of mask is (batchSize^(batchSize-1)) - 1.
        // So, rem * (batchSize^(batchSize-1)) + mask creates a unique key.
        const memoKey = rem * (batchSize ** (batchSize - 1)) + mask;

        if (memo.has(memoKey)) {
            return memo.get(memoKey);
        }

        let maxAdditionalGroups = 0;
        // Unpack mask to get current counts for processing
        const currentCounts = getCountsFromMask(mask);

        // Iterate through all possible group types (remainders r from 1 to batchSize-1)
        // and try serving one group of that type.
        for (let r = 1; r < batchSize; r++) {
            if (currentCounts[r] > 0) {
                currentCounts[r]--; // Temporarily decrement count for group type r

                // Calculate the new remainder after serving this group
                let nextRem;
                if (rem === 0) { // If current batch is fresh, new remainder is (batchSize - r) % batchSize
                    nextRem = (batchSize - r) % batchSize;
                } else { // If current batch has 'rem' donuts, new remainder is (rem - r + batchSize) % batchSize
                    nextRem = (rem - r + batchSize) % batchSize;
                }

                let currentGroupsGettingFresh = 0;
                // If serving this group makes the batch empty (nextRem becomes 0),
                // it means the *next* group served will get fresh donuts.
                // So, we count 1 for the potential next fresh batch.
                if (nextRem === 0) {
                    currentGroupsGettingFresh = 1;
                }

                // Recurse with the new remainder and updated counts (packed into a new mask)
                const newMask = getMask(currentCounts);
                maxAdditionalGroups = Math.max(maxAdditionalGroups, currentGroupsGettingFresh + solve(nextRem, newMask));

                currentCounts[r]++; // Backtrack: restore count for the next iteration in this loop
            }
        }

        memo.set(memoKey, maxAdditionalGroups);
        return maxAdditionalGroups;
    }

    // Initial call to DP: Start with a fresh batch (rem = 0) and the initial counts (after optimizations).
    // The initial counts array already has 0 for counts[0], which is correctly ignored by getMask.
    const initialMask = getMask(counts);
    ans += solve(0, initialMask);

    return ans;
};