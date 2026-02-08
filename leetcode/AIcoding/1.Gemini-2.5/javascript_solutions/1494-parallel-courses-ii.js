var minNumberOfSemesters = function(n, relations, k) {
    // preReqs[i] will store a bitmask of courses that are prerequisites for course i (0-indexed)
    const preReqs = new Array(n).fill(0);
    for (const [prevCourse, nextCourse] of relations) {
        // Convert to 0-indexed
        preReqs[nextCourse - 1] |= (1 << (prevCourse - 1));
    }

    // dp[mask] stores the minimum number of terms to complete courses represented by 'mask'
    // Initialize with infinity. dp[0] = 0 (0 terms for 0 courses).
    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    // Helper function to count set bits in a number (popcount)
    const countSetBits = (num) => {
        let count = 0;
        while (num > 0) {
            num &= (num - 1);
            count++;
        }
        return count;
    };

    // Iterate through all possible masks (states of completed courses) from 1 to (1 << n) - 1
    // We build up the DP table from smaller masks to larger masks.
    for (let mask = 1; mask < (1 << n); mask++) {
        // Iterate through all non-empty subsets 'submask' of the current 'mask'.
        // 'submask' represents the courses that could have been taken in the *last* term
        // to reach the current 'mask' state.
        for (let submask = mask; submask > 0; submask = (submask - 1) & mask) {
            // Condition 1: The number of courses taken in 'submask' must be at most 'k'.
            if (countSetBits(submask) > k) {
                continue;
            }

            // 'prevMask' is the state of courses completed *before* taking 'submask' courses.
            const prevMask = mask ^ submask;

            // If 'prevMask' is an unreachable state, then 'mask' cannot be reached this way.
            if (dp[prevMask] === Infinity) {
                continue;
            }

            // Condition 2: All courses in 'submask' must have been *available* to take
            // when 'prevMask' courses were completed.
            let availableToTakeFromPrevMask = 0;
            for (let i = 0; i < n; i++) {
                // A course 'i' is available if:
                // 1. It has not been taken yet (not in 'prevMask').
                // 2. All its prerequisites are already in 'prevMask'.
                if (!((prevMask >> i) & 1) && ((preReqs[i] & prevMask) === preReqs[i])) {
                    availableToTakeFromPrevMask |= (1 << i);
                }
            }

            // Check if all courses in 'submask' were indeed available to take from 'prevMask'.
            // This is true if 'submask' is a subset of 'availableToTakeFromPrevMask'.
            if ((submask & availableToTakeFromPrevMask) === submask) {
                // Update dp[mask] with the minimum terms found so far.
                // It takes 1 more term than dp[prevMask].
                dp[mask] = Math.min(dp[mask], dp[prevMask] + 1);
            }
        }
    }

    // The result is the minimum number of terms to complete all 'n' courses,
    // which corresponds to the mask where all bits are set: (1 << n) - 1.
    return dp[(1 << n) - 1];
};