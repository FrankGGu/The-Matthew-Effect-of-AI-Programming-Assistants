var uniqueOccurrences = function(arr) {
    const counts = new Map();
    for (const num of arr) {
        counts.set(num, (counts.get(num) || 0) + 1);
    }

    const occurrenceSet = new Set();
    for (const count of counts.values()) {
        occurrenceSet.add(count);
    }

    return counts.size === occurrenceSet.size;
};