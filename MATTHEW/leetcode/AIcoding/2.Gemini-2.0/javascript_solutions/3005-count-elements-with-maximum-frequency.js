var maxFrequencyElements = function(nums) {
    const freqMap = new Map();
    let maxFreq = 0;

    for (const num of nums) {
        const freq = (freqMap.get(num) || 0) + 1;
        freqMap.set(num, freq);
        maxFreq = Math.max(maxFreq, freq);
    }

    let count = 0;
    for (const freq of freqMap.values()) {
        if (freq === maxFreq) {
            count++;
        }
    }

    return count * maxFreq;
};