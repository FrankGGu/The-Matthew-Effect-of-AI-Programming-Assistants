var findLonely = function(nums) {
    const freqMap = new Map();
    for (const num of nums) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    const lonelyNumbers = [];
    for (const num of nums) {
        if (freqMap.get(num) === 1) {
            if (!freqMap.has(num - 1) && !freqMap.has(num + 1)) {
                lonelyNumbers.push(num);
            }
        }
    }

    return lonelyNumbers;
};