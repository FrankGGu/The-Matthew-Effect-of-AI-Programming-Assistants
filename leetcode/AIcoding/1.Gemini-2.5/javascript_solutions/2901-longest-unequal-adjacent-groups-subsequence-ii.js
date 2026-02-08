var longestUnequalAdjacentGroupsSubsequence = function(lengths, colors) {
    const N = lengths.length;

    // dp[i] stores { len: number, prev: number }
    // len: length of the longest subsequence ending at index i
    // prev: the previous index in that subsequence, or -1 if it's the first element
    const dp = Array(N).fill(null).map((_, i) => ({ len: 1, prev: -1 }));

    // memoCompare[idx1][idx2] stores the result of comparing paths ending at idx1 and idx2
    // -1: path ending idx1 is lexicographically smaller
    //  1: path ending idx2 is lexicographically smaller
    //  0: paths are equal
    // undefined: not yet computed
    const memoCompare = Array(N).fill(null).map(() => Array(N).fill(undefined));

    // Function to compare two paths represented by their ending indices (idx1 and idx2).
    // It returns:
    //   < 0 if path ending idx1 is lexicographically smaller
    //   > 0 if path ending idx2 is lexicographically smaller
    //   0 if paths are equal
    // This function uses memoization to achieve O(N^2) total comparison time across all calls.
    const comparePaths = (idx1, idx2) => {
        // Base cases for empty paths (when prev is -1)
        if (idx1 === -1 && idx2 === -1) return 0; // Both paths are empty, they are equal
        if (idx1 === -1) return -1; // Path ending idx1 is shorter (empty), thus lexicographically smaller
        if (idx2 === -1) return 1;  // Path ending idx2 is shorter (empty), thus lexicographically smaller

        // Check memoization table to avoid redundant computations
        if (memoCompare[idx1][idx2] !== undefined) {
            return memoCompare[idx1][idx2];
        }

        // Recursively compare the prefixes of the paths
        const res = comparePaths(dp[idx1].prev, dp[idx2].prev);

        if (res !== 0) {
            // If prefixes are different, their comparison result determines the overall result
            memoCompare[idx1][idx2] = res;
            return res;
        } else {
            // If prefixes are equal, compare the current indices themselves
            // A smaller index means a lexicographically smaller path
            const finalRes = idx1 - idx2;
            memoCompare[idx1][idx2] = finalRes;
            return finalRes;
        }
    };

    // Dynamic Programming loop to fill the dp table
    for (let i = 0; i < N; i++) {
        for (let j = 0; j < i; j++) {
            // Check conditions for forming an adjacent group in the subsequence
            // (lengths must be different AND colors must be different)
            if (lengths[j] !== lengths[i] && colors[j] !== colors[i]) {
                const newLen = dp[j].len + 1;
                const currentLen = dp[i].len;

                if (newLen > currentLen) {
                    // Found a strictly longer subsequence ending at i
                    dp[i] = { len: newLen, prev: j };
                } else if (newLen === currentLen) {
                    // Found a subsequence of the same length
                    // Need to compare paths to find the lexicographically smallest one
                    // We compare the path ending at j (which would be followed by i)
                    // with the current best path ending at dp[i].prev (which is also followed by i)
                    // If comparePaths(j, dp[i].prev) < 0, it means the path ending at j is smaller.
                    if (comparePaths(j, dp[i].prev) < 0) {
                        dp[i] = { len: newLen, prev: j };
                    }
                }
            }
        }
    }

    // After filling the dp table, find the overall longest and lexicographically smallest subsequence
    let maxLen = 0;
    let endIdx = -1; // Stores the ending index of the best subsequence

    for (let i = 0; i < N; i++) {
        if (dp[i].len > maxLen) {
            // Found a strictly longer subsequence
            maxLen = dp[i].len;
            endIdx = i;
        } else if (dp[i].len === maxLen) {
            // Found a subsequence of the same length
            // Compare paths to find the lexicographically smallest one
            // If comparePaths(i, endIdx) < 0, it means the path ending at i is smaller.
            if (comparePaths(i, endIdx) < 0) {
                endIdx = i;
            }
        }
    }

    // Reconstruct the path from the chosen endIdx
    const result = [];
    let curr = endIdx;
    while (curr !== -1) {
        result.push(curr);
        curr = dp[curr].prev;
    }

    // The path is built in reverse order (from end to start), so reverse it back
    return result.reverse();
};