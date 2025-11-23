var findLucky = function(arr) {
    const freqMap = {};
    for (const num of arr) {
        freqMap[num] = (freqMap[num] || 0) + 1;
    }

    let maxLucky = -1;
    for (const numStr in freqMap) {
        const num = parseInt(numStr);
        const freq = freqMap[numStr];
        if (num === freq) {
            maxLucky = Math.max(maxLucky, num);
        }
    }

    return maxLucky;
};