function uniqueOccurrences(arr) {
    const count = {};
    for (const num of arr) {
        count[num] = (count[num] || 0) + 1;
    }
    const occurrences = Object.values(count);
    const set = new Set(occurrences);
    return set.size === occurrences.length;
}