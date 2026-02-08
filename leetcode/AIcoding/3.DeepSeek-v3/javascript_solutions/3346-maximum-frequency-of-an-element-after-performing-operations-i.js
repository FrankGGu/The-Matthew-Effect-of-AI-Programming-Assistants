var maxFrequencyElements = function(nums) {
    const freq = {};
    let maxFreq = 0;
    let count = 0;

    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
        if (freq[num] > maxFreq) {
            maxFreq = freq[num];
            count = maxFreq;
        } else if (freq[num] === maxFreq) {
            count += maxFreq;
        }
    }

    return count;
};