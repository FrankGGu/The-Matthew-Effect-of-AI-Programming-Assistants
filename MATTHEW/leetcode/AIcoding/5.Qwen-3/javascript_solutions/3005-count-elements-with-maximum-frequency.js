var maxFrequencyElements = function(nums) {
    const freq = {};
    let maxFreq = 0;
    let count = 0;

    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
        maxFreq = Math.max(maxFreq, freq[num]);
    }

    for (const key in freq) {
        if (freq[key] === maxFreq) {
            count += freq[key];
        }
    }

    return count;
};