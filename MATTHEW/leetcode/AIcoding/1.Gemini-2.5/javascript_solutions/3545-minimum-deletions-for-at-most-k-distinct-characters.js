var minDeletions = function(s, k) {
    const freqMap = new Map();
    for (const char of s) {
        freqMap.set(char, (freqMap.get(char) || 0) + 1);
    }

    const frequencies = Array.from(freqMap.values());
    frequencies.sort((a, b) => a - b);

    let deletions = 0;
    let distinctCount = frequencies.length;

    for (let i = 0; i < frequencies.length; i++) {
        if (distinctCount > k) {
            deletions += frequencies[i];
            distinctCount--;
        } else {
            break;
        }
    }

    return deletions;
};