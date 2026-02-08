var mostFrequentEven = function(nums) {
    const freqMap = {};
    for (const num of nums) {
        if (num % 2 === 0) {
            freqMap[num] = (freqMap[num] || 0) + 1;
        }
    }

    let maxFreq = 0;
    let result = -1;

    for (const numStr in freqMap) {
        const num = parseInt(numStr);
        const currentFreq = freqMap[num];

        if (currentFreq > maxFreq) {
            maxFreq = currentFreq;
            result = num;
        } else if (currentFreq === maxFreq) {
            if (num < result) {
                result = num;
            }
        }
    }

    return result;
};