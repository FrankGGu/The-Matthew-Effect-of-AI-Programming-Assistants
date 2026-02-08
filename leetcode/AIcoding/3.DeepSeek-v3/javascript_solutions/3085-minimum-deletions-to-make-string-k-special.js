var minimumDeletions = function(s, k) {
    const freq = {};
    for (const char of s) {
        freq[char] = (freq[char] || 0) + 1;
    }
    const counts = Object.values(freq).sort((a, b) => a - b);
    let minDeletions = Infinity;
    for (let i = 0; i < counts.length; i++) {
        let deletions = 0;
        const target = counts[i];
        for (let j = 0; j < counts.length; j++) {
            if (counts[j] < target) {
                deletions += counts[j];
            } else if (counts[j] > target + k) {
                deletions += counts[j] - (target + k);
            }
        }
        minDeletions = Math.min(minDeletions, deletions);
    }
    return minDeletions;
};