var minDeletions = function(s) {
    const freqMap = new Map();
    for (const char of s) {
        freqMap.set(char, (freqMap.get(char) || 0) + 1);
    }

    const frequencies = [];
    for (const freq of freqMap.values()) {
        frequencies.push(freq);
    }

    frequencies.sort((a, b) => b - a); // Sort in descending order

    let deletions = 0;
    const seenFrequencies = new Set();

    for (let i = 0; i < frequencies.length; i++) {
        let currentFreq = frequencies[i];

        while (currentFreq > 0 && seenFrequencies.has(currentFreq)) {
            currentFreq--;
            deletions++;
        }

        if (currentFreq > 0) {
            seenFrequencies.add(currentFreq);
        }
    }

    return deletions;
};