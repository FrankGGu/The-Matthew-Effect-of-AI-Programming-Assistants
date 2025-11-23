var findLeastNumOfUniqueInts = function(arr, k) {
    const freqMap = new Map();
    for (const num of arr) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    const frequencies = Array.from(freqMap.values());
    frequencies.sort((a, b) => a - b);

    let uniqueCount = frequencies.length;

    for (const freq of frequencies) {
        if (k >= freq) {
            k -= freq;
            uniqueCount--;
        } else {
            break;
        }
    }

    return uniqueCount;
};