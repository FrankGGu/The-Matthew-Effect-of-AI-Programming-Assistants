var equalFrequency = function(word) {
    const charCounts = new Array(26).fill(0);
    for (let i = 0; i < word.length; i++) {
        charCounts[word.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    // Try removing one instance of each character type
    for (let i = 0; i < 26; i++) {
        if (charCounts[i] > 0) {
            charCounts[i]--; // Temporarily remove one instance of the current character

            const frequencyOfFrequencies = new Map();
            for (let j = 0; j < 26; j++) {
                if (charCounts[j] > 0) { // Only consider characters that still exist
                    frequencyOfFrequencies.set(charCounts[j], (frequencyOfFrequencies.get(charCounts[j]) || 0) + 1);
                }
            }

            // Check if all remaining non-zero frequencies are equal
            // This is true if there's at most one distinct frequency value
            // (e.g., all remaining characters have frequency X, or no characters are left)
            if (frequencyOfFrequencies.size <= 1) {
                return true;
            }

            charCounts[i]++; // Restore the count for the next iteration
        }
    }

    return false;
};