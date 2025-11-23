var findLeastNumOfUniqueInts = function(arr, k) {
    const frequencyMap = new Map();
    for (const num of arr) {
        frequencyMap.set(num, (frequencyMap.get(num) || 0) + 1);
    }

    const frequencies = Array.from(frequencyMap.values()).sort((a, b) => a - b);

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