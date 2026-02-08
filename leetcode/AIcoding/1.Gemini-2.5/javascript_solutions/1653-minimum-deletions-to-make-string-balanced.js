var minimumDeletions = function(s) {
    let bCount = 0;
    let aCountSuffix = 0;

    // Calculate initial count of 'a's in the entire string (suffix)
    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'a') {
            aCountSuffix++;
        }
    }

    // Initialize minDeletions. This covers the case where the final string is all 'b's.
    // In this case, we delete all 'a's, which is aCountSuffix.
    let minDeletions = aCountSuffix;

    // Iterate through the string to find the optimal split point
    // A split point means characters to the left are 'a's and to the right are 'b's.
    // For each character s[i], we consider it as the potential boundary:
    // s[0...i] are 'a's, s[i+1...end] are 'b's.
    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'a') {
            // If s[i] is 'a', it moves from the suffix part to the prefix part.
            // So, decrease aCountSuffix.
            aCountSuffix--;
        } else { // s[i] === 'b'
            // If s[i] is 'b', it moves from the suffix part to the prefix part.
            // So, increase bCount (b's in the prefix).
            bCount++;
        }

        // Calculate deletions for the current split point:
        // bCount: number of 'b's in the prefix (s[0...i]) that need to be deleted
        // aCountSuffix: number of 'a's in the suffix (s[i+1...end]) that need to be deleted
        minDeletions = Math.min(minDeletions, bCount + aCountSuffix);
    }

    return minDeletions;
};