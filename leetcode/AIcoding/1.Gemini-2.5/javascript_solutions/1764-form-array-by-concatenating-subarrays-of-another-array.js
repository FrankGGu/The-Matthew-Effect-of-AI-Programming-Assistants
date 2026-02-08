var canChoose = function(groups, nums) {
    let numsPointer = 0;

    // Helper function to compute LPS array for KMP algorithm
    // lps[i] stores the length of the longest proper prefix of pattern[0...i]
    // that is also a suffix of pattern[0...i].
    function computeLPSArray(pattern) {
        const M = pattern.length;
        const lps = new Array(M).fill(0);
        let len = 0; // Length of the previous longest prefix suffix
        let i = 1;

        while (i < M) {
            if (pattern[i] === pattern[len]) {
                len++;
                lps[i] = len;
                i++;
            } else {
                // This is tricky. Consider pattern[i] != pattern[len].
                // We don't match, so we need to try a shorter prefix.
                // The length of the shorter prefix is lps[len-1].
                if (len !== 0) {
                    len = lps[len - 1];
                } else {
                    // If len is 0, no proper prefix is also a suffix.
                    // So lps[i] is 0, and we move to the next character in pattern.
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps;
    }

    // Helper function for KMP search
    // Searches for 'pattern' in 'text' starting from 'startIndex'.
    // Returns the index in 'text' *after* the matched pattern, or -1 if not found.
    function KMPSearch(text, pattern, lps, startIndex) {
        const N = text.length;
        const M = pattern.length;

        // If the pattern is longer than the remaining text, it cannot be found.
        if (startIndex + M > N) {
            return -1;
        }

        let i = startIndex; // Index for text
        let j = 0;          // Index for pattern

        while (i < N) {
            if (pattern[j] === text[i]) {
                i++;
                j++;
            }

            if (j === M) {
                // Pattern found. Return the index in text *after* the match.
                return i;
            } else if (i < N && pattern[j] !== text[i]) {
                // Mismatch after j matches
                // Do not match lps[0...lps[j-1]] characters,
                // they will match anyway
                if (j !== 0) {
                    j = lps[j - 1];
                } else {
                    // If j is 0, we just move to the next character in text
                    i++;
                }
            }
        }
        return -1; // Pattern not found
    }

    for (let groupIdx = 0; groupIdx < groups.length; groupIdx++) {
        const currentGroup = groups[groupIdx];
        const lps = computeLPSArray(currentGroup);

        // Search for currentGroup in nums starting from numsPointer
        const matchEndIndex = KMPSearch(nums, currentGroup, lps, numsPointer);

        if (matchEndIndex === -1) {
            // If the current group cannot be found, we cannot form the array
            return false;
        }
        // Update numsPointer to start searching for the next group
        // immediately after the current match
        numsPointer = matchEndIndex;
    }

    // If all groups were found in sequence, return true
    return true;
};