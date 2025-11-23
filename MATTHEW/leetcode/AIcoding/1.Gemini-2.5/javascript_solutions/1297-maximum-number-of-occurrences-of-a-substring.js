var maxFreq = function(s, maxLetters, minSize, maxSize) {
    const n = s.length;
    if (n < minSize) {
        return 0;
    }

    const charCounts = new Array(26).fill(0);
    let uniqueCount = 0;
    const freqMap = new Map();
    let maxOccurrences = 0;

    // Initialize the first window of size minSize
    for (let i = 0; i < minSize; i++) {
        const charCode = s.charCodeAt(i) - 97; // 'a' is 97
        if (charCounts[charCode] === 0) {
            uniqueCount++;
        }
        charCounts[charCode]++;
    }

    // Check the first window
    if (uniqueCount <= maxLetters) {
        const sub = s.substring(0, minSize);
        freqMap.set(sub, (freqMap.get(sub) || 0) + 1);
        maxOccurrences = Math.max(maxOccurrences, freqMap.get(sub));
    }

    // Slide the window
    for (let i = 1; i <= n - minSize; i++) {
        // Remove the character leaving the window
        const charToRemoveCode = s.charCodeAt(i - 1) - 97;
        charCounts[charToRemoveCode]--;
        if (charCounts[charToRemoveCode] === 0) {
            uniqueCount--;
        }

        // Add the character entering the window
        const charToAddCode = s.charCodeAt(i + minSize - 1) - 97;
        if (charCounts[charToAddCode] === 0) {
            uniqueCount++;
        }
        charCounts[charToAddCode]++;

        // Check the current window
        if (uniqueCount <= maxLetters) {
            const sub = s.substring(i, i + minSize);
            freqMap.set(sub, (freqMap.get(sub) || 0) + 1);
            maxOccurrences = Math.max(maxOccurrences, freqMap.get(sub));
        }
    }

    return maxOccurrences;
};