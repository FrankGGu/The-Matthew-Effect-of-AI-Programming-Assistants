var minimizeConcatenatedLength = function(words) {
    if (words.length === 0) {
        return 0;
    }

    // Helper function to calculate the length of the longest suffix of s1 that is also a prefix of s2.
    // This function is efficient because s1 (currentSuffix) and s2 (currentWord) will have limited lengths.
    function getOverlap(s1, s2) {
        let maxOverlap = 0;
        const len1 = s1.length;
        const len2 = s2.length;

        // The maximum possible overlap length is limited by the length of the shorter string.
        // Since words[i].length is at most 100, the overlap length cannot exceed 100.
        // The `currentSuffix` also has its length capped at 100, so len1 will be at most 100.
        for (let i = 1; i <= Math.min(len1, len2); i++) {
            // Check if the suffix of s1 of length i matches the prefix of s2 of length i
            if (s1.substring(len1 - i) === s2.substring(0, i)) {
                maxOverlap = i;
            }
        }
        return maxOverlap;
    }

    // Initialize with the first word
    // `currentSuffix` stores the relevant suffix of the concatenated string.
    // We only need to store a suffix of length up to the maximum possible word length (100)
    // because any overlap with a future word cannot exceed that length.
    let currentSuffix = words[0];
    let totalCost = words[0].length;

    // Iterate through the rest of the words (from the second word onwards)
    for (let i = 1; i < words.length; i++) {
        const currentWord = words[i];

        // Calculate overlap between the current suffix of the concatenated string and the new word
        const overlap = getOverlap(currentSuffix, currentWord);

        // Add the length of the current word, subtracting the overlap to get the net added length
        totalCost += currentWord.length - overlap;

        // Update the `currentSuffix` for the next iteration.
        // Append only the non-overlapping part of the `currentWord`.
        currentSuffix += currentWord.substring(overlap);

        // Trim `currentSuffix` if it exceeds the maximum relevant length.
        // The maximum length of a word is 100. If `currentSuffix` is 100 chars and `currentWord` is 100 chars
        // with 0 overlap, `currentSuffix` could become 200 chars. We only need the last 100.
        const MAX_SUFFIX_LENGTH = 100; 
        if (currentSuffix.length > MAX_SUFFIX_LENGTH) {
            currentSuffix = currentSuffix.substring(currentSuffix.length - MAX_SUFFIX_LENGTH);
        }
    }

    return totalCost;
};