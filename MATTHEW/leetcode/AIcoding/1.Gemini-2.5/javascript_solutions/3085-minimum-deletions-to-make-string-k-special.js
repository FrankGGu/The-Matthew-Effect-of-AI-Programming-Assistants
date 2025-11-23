var minimumDeletions = function(s, k) {
    const freqMap = new Map();
    for (const char of s) {
        freqMap.set(char, (freqMap.get(char) || 0) + 1);
    }

    let totalDeletions = 0;
    for (const freq of freqMap.values()) {
        if (freq > k) {
            totalDeletions += (freq - k);
        }
    }

    return totalDeletions;
};