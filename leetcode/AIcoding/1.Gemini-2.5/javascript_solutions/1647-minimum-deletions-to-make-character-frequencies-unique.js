var minDeletions = function(s) {
    const freqMap = new Map();
    for (const char of s) {
        freqMap.set(char, (freqMap.get(char) || 0) + 1);
    }

    const uniqueFrequencies = new Set();
    let deletions = 0;

    for (let freq of freqMap.values()) {
        while (freq > 0 && uniqueFrequencies.has(freq)) {
            freq--;
            deletions++;
        }
        if (freq > 0) {
            uniqueFrequencies.add(freq);
        }
    }

    return deletions;
};