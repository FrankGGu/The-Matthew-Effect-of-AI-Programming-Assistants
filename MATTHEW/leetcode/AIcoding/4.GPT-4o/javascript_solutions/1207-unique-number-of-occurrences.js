var uniqueOccurrences = function(arr) {
    const freq = {};
    for (const num of arr) {
        freq[num] = (freq[num] || 0) + 1;
    }
    const occurrences = new Set(Object.values(freq));
    return occurrences.size === Object.keys(freq).length;
};