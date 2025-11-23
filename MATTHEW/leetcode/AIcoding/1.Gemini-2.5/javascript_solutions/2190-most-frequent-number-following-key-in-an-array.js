var mostFrequent = function(nums, key) {
    const freqMap = new Map();

    for (let i = 0; i < nums.length - 1; i++) {
        if (nums[i] === key) {
            const target = nums[i + 1];
            freqMap.set(target, (freqMap.get(target) || 0) + 1);
        }
    }

    let maxFreq = 0;
    let result = -1;

    for (const [target, freq] of freqMap.entries()) {
        if (freq > maxFreq) {
            maxFreq = freq;
            result = target;
        } else if (freq === maxFreq) {
            result = Math.min(result, target);
        }
    }

    return result;
};