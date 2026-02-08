var uniqueOccurrences = function(arr) {
    const freq = {};
    for (const num of arr) {
        freq[num] = (freq[num] || 0) + 1;
    }
    const occurrences = Object.values(freq);
    const unique = new Set(occurrences);
    return occurrences.length === unique.size;
};