var minDeletions = function(s, k) {
    const freq = {};
    for (const char of s) {
        freq[char] = (freq[char] || 0) + 1;
    }
    const counts = Object.values(freq).sort((a, b) => a - b);
    let deletions = 0;
    for (let i = 0; i < counts.length; i++) {
        if (counts[i] < counts[counts.length - 1] - k) {
            deletions += counts[i];
        } else if (counts[i] > counts[counts.length - 1] - k) {
            deletions += counts[i] - (counts[counts.length - 1] - k);
        }
    }
    return deletions;
};