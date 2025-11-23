function findLeastNumOfUniqueInts(arr, k) {
    const freq = new Map();
    for (const num of arr) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    const counts = Array.from(freq.values()).sort((a, b) => a - b);

    let removed = 0;
    for (let i = 0; i < counts.length; i++) {
        if (counts[i] <= k) {
            k -= counts[i];
            removed++;
        } else {
            break;
        }
    }

    return counts.length - removed;
}