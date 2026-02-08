var mostFrequentEven = function(nums) {
    const freqMap = {};
    for (const num of nums) {
        if (num % 2 === 0) {
            freqMap[num] = (freqMap[num] || 0) + 1;
        }
    }
    let mostFrequent = -1;
    let maxFrequency = 0;

    for (const [num, freq] of Object.entries(freqMap)) {
        if (freq > maxFrequency || (freq === maxFrequency && num < mostFrequent)) {
            mostFrequent = Number(num);
            maxFrequency = freq;
        }
    }

    return mostFrequent;
};