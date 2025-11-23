var minDeletions = function(s, k) {
    const freqMap = new Map();
    for (const char of s) {
        freqMap.set(char, (freqMap.get(char) || 0) + 1);
    }

    const freqs = Array.from(freqMap.values()).sort((a, b) => b - a);
    let deletions = 0;
    const usedFreqs = new Set();

    for (const freq of freqs) {
        let currentFreq = freq;
        while (currentFreq > 0 && usedFreqs.has(currentFreq)) {
            currentFreq--;
            deletions++;
        }
        if (currentFreq > 0) {
            usedFreqs.add(currentFreq);
        }
    }

    return deletions;
};