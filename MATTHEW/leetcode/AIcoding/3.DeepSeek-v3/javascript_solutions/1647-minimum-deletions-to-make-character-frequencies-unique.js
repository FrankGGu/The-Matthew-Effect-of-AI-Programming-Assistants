var minDeletions = function(s) {
    const freq = {};
    for (const char of s) {
        freq[char] = (freq[char] || 0) + 1;
    }

    const counts = Object.values(freq).sort((a, b) => b - a);
    let deletions = 0;
    for (let i = 1; i < counts.length; i++) {
        while (counts[i] >= counts[i - 1] && counts[i] > 0) {
            counts[i]--;
            deletions++;
        }
    }
    return deletions;
};