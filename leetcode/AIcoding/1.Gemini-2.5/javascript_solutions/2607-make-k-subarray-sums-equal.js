var makeSubKSumEqual = function(nums, k) {
    const n = nums.length;
    let totalChanges = 0;

    for (let i = 0; i < k; i++) {
        const freqMap = new Map();
        let groupSize = 0;
        let maxFreq = 0;

        for (let j = i; j < n; j += k) {
            const num = nums[j];
            groupSize++;
            const currentFreq = (freqMap.get(num) || 0) + 1;
            freqMap.set(num, currentFreq);
            maxFreq = Math.max(maxFreq, currentFreq);
        }
        totalChanges += (groupSize - maxFreq);
    }

    return totalChanges;
};