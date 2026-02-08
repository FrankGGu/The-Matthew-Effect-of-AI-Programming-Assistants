var minLengthAfterRemovals = function(nums) {
    const n = nums.length;
    if (n === 0) {
        return 0;
    }

    const freqMap = new Map();
    for (const num of nums) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    let maxFreq = 0;
    for (const count of freqMap.values()) {
        if (count > maxFreq) {
            maxFreq = count;
        }
    }

    return Math.max(n % 2, 2 * maxFreq - n);
};