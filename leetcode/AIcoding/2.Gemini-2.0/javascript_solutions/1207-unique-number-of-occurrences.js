var uniqueOccurrences = function(arr) {
    const counts = {};
    for (const num of arr) {
        counts[num] = (counts[num] || 0) + 1;
    }

    const occurrences = Object.values(counts);
    const uniqueOccurrencesSet = new Set(occurrences);

    return occurrences.length === uniqueOccurrencesSet.size;
};