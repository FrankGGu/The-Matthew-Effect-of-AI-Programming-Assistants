function maxDeletions(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    const frequencies = Object.values(count).sort((a, b) => a - b);
    let deletions = 0;
    let maxAllowed = Infinity;

    for (let freq of frequencies) {
        if (freq > maxAllowed) {
            deletions += freq - maxAllowed;
            freq = maxAllowed;
        }
        maxAllowed = freq - 1;
    }

    return deletions;
}