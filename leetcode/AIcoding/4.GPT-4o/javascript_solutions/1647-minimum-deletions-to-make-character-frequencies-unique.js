var minDeletions = function(s) {
    const freq = new Array(26).fill(0);
    for (const char of s) {
        freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    freq.sort((a, b) => b - a);
    let deletions = 0;
    let maxAllowedFreq = freq[0];

    for (let i = 0; i < freq.length; i++) {
        if (freq[i] > maxAllowedFreq) {
            deletions += freq[i] - maxAllowedFreq;
            freq[i] = maxAllowedFreq;
        }
        maxAllowedFreq = Math.max(0, maxAllowedFreq - 1);
    }

    return deletions;
};