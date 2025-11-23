var minBooths = function(needs) {
    const freq = {};
    for (const ch of needs) {
        freq[ch] = (freq[ch] || 0) + 1;
    }
    let maxCount = 0;
    for (const ch in freq) {
        maxCount = Math.max(maxCount, freq[ch]);
    }
    return maxCount;
};