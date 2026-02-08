var maxFreq = function(s, maxLetters, minSize, maxSize) {
    let count = new Map();
    let n = s.length;

    for (let size = minSize; size <= maxSize; size++) {
        for (let i = 0; i <= n - size; i++) {
            let substring = s.substring(i, i + size);
            let letterSet = new Set(substring);
            if (letterSet.size <= maxLetters) {
                count.set(substring, (count.get(substring) || 0) + 1);
            }
        }
    }

    let maxOccurrences = 0;
    for (let freq of count.values()) {
        maxOccurrences = Math.max(maxOccurrences, freq);
    }

    return maxOccurrences;
};