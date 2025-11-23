var mostFrequentEven = function(nums) {
    const freq = {};
    let maxFreq = 0;
    let result = -1;

    for (const num of nums) {
        if (num % 2 === 0) {
            freq[num] = (freq[num] || 0) + 1;
            if (freq[num] > maxFreq || (freq[num] === maxFreq && num < result)) {
                maxFreq = freq[num];
                result = num;
            }
        }
    }

    return result;
};