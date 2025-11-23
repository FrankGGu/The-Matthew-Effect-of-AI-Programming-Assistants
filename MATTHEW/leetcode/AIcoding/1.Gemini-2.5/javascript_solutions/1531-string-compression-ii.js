var getLengthOfOptimalCompression = function(s, k) {
    const n = s.length;

    // dp[i][j] will store the minimum length to compress s[0...i-1] after deleting j characters.
    // The maximum value for j (deletions) is n.
    // So dp table size is (n+1) x (n+1).
    const dp = Array(n + 1).fill(0).map(() => Array(n + 1).fill(Infinity));

    // Base case: empty string, 0 deletions, length is 0.
    dp[0][0] = 0;

    // Helper function to calculate the compressed length for a given count.
    const getLen = (count) => {
        if (count === 0) return 0;
        if (count === 1) return 1;
        if (count < 10) return 2; // e.g., "a2"
        if (count < 100) return 3; // e.g., "a10"
        return 4; // e.g., "a100"
    };

    // Iterate through string prefixes
    for (let i = 1; i <= n; i++) {
        // Iterate through possible number of deletions
        for (let j = 0; j <= k; j++) {
            // Option 1: Delete s[i-1]
            // If we have deletions available, we can delete the current character.
            if (j > 0) {
                dp[i][j] = dp[i-1][j-1];
            }

            // Option 2: Keep s[i-1] as part of a block ending at s[i-1]
            // We look back from s[i-1] to find the start of the current block.
            let charCounts = new Array(26).fill(0);
            let maxFreq = 0;

            // Iterate p from i-1 down to 0, considering s[p...i-1] as the current segment
            for (let p = i - 1; p >= 0; p--) {
                const charIndex = s.charCodeAt(p) - 'a'.charCodeAt(0);
                charCounts[charIndex]++;
                maxFreq = Math.max(maxFreq, charCounts[charIndex]);

                // The length of the current segment s[p...i-1] is (i - p).
                // To compress this segment into a single character block (e.g., 'a' or 'a3'),
                // we keep 'maxFreq' occurrences of the most frequent character
                // and delete the rest.
                const charsToDeleteInSegment = (i - p) - maxFreq;

                // If we have enough deletions available (j - charsToDeleteInSegment >= 0)
                // for the prefix s[0...p-1] and the current segment s[p...i-1],
                // then we can update dp[i][j].
                if (j - charsToDeleteInSegment >= 0) {
                    const prevKDeletions = j - charsToDeleteInSegment;
                    if (dp[p][prevKDeletions] !== Infinity) {
                        dp[i][j] = Math.min(dp[i][j], dp[p][prevKDeletions] + getLen(maxFreq));
                    }
                }
            }
        }
    }

    return dp[n][k];
};