var subsequenceWithTheMinimumScore = function(s, t) {
    let minOverallScore = Infinity;

    // Helper function to check if a common subsequence exists
    // where all characters are within the range [minValInt, maxValInt].
    // This uses a two-pointer approach to find if s_filtered has any common character with t_filtered.
    const check = (s, t, minValInt, maxValInt) => {
        let sPtr = 0;
        let tPtr = 0;

        while (sPtr < s.length && tPtr < t.length) {
            let sCharVal = parseInt(s[sPtr]);

            // Skip characters in s that are out of the allowed range
            while (sPtr < s.length && (sCharVal < minValInt || sCharVal > maxValInt)) {
                sPtr++;
                if (sPtr < s.length) {
                    sCharVal = parseInt(s[sPtr]);
                }
            }
            if (sPtr === s.length) {
                return false; // No more valid characters in s
            }

            let tCharVal = parseInt(t[tPtr]);
            let tempTPtr = tPtr;

            // Find the first character in t (from tempTPtr onwards) that is
            // within the allowed range AND matches s[sPtr]
            while (tempTPtr < t.length && (tCharVal < minValInt || tCharVal > maxValInt || sCharVal !== tCharVal)) {
                tempTPtr++;
                if (tempTPtr < t.length) {
                    tCharVal = parseInt(t[tempTPtr]);
                }
            }

            if (tempTPtr === t.length) {
                // No match found for s[sPtr] in t from tPtr onwards
                sPtr++; // Move to the next character in s
                continue;
            }

            // A match is found: s[sPtr] == t[tempTPtr], and both are in range.
            // This single character forms a common subsequence.
            return true;
        }

        return false; // No common subsequence found within the specified range
    };

    // Iterate through all possible minimum and maximum digit values (0-9)
    for (let minCharVal = 0; minCharVal <= 9; minCharVal++) {
        for (let maxCharVal = minCharVal; maxCharVal <= 9; maxCharVal++) {
            // If a common subsequence exists with all characters in the range [minCharVal, maxCharVal]
            if (check(s, t, minCharVal, maxCharVal)) {
                // Update the minimum overall score
                minOverallScore = Math.min(minOverallScore, maxCharVal - minCharVal);
            }
        }
    }

    return minOverallScore;
};