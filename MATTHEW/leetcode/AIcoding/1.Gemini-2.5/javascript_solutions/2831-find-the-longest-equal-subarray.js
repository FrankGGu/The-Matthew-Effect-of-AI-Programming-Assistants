var longestEqualSubarray = function(nums, k) {
    let i = 0;
    let maxFreq = 0;
    const freqMap = new Map();

    for (let j = 0; j < nums.length; j++) {
        freqMap.set(nums[j], (freqMap.get(nums[j]) || 0) + 1);
        maxFreq = Math.max(maxFreq, freqMap.get(nums[j]));

        if ((j - i + 1) - maxFreq > k) {
            freqMap.set(nums[i], freqMap.get(nums[i]) - 1);
            i++;
        }
    }

    return maxFreq;
};