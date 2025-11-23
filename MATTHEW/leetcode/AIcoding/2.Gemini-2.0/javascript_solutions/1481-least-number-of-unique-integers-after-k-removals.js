var findLeastNumOfUniqueInts = function(arr, k) {
    const counts = {};
    for (const num of arr) {
        counts[num] = (counts[num] || 0) + 1;
    }

    const frequencies = Object.values(counts).sort((a, b) => a - b);
    let removed = 0;
    let uniqueCount = frequencies.length;

    for (let i = 0; i < frequencies.length; i++) {
        if (k >= frequencies[i]) {
            k -= frequencies[i];
            removed++;
            uniqueCount--;
        } else {
            break;
        }
    }

    return uniqueCount;
};