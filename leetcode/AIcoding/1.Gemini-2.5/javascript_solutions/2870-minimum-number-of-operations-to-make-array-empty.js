var minOperations = function(nums) {
    const freqMap = new Map();
    for (const num of nums) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    let totalOperations = 0;
    for (const freq of freqMap.values()) {
        if (freq === 1) {
            return -1;
        }
        totalOperations += Math.ceil(freq / 3);
    }

    return totalOperations;
};