var maxFrequencyElements = function(nums) {
    const frequency = {};
    let maxFreq = 0;
    let count = 0;

    for (const num of nums) {
        frequency[num] = (frequency[num] || 0) + 1;
        if (frequency[num] > maxFreq) {
            maxFreq = frequency[num];
            count = 1;
        } else if (frequency[num] === maxFreq) {
            count++;
        }
    }

    return count * maxFreq;
};