var mostFrequent = function(nums, key) {
    const freqMap = new Map();
    for (let i = 0; i < nums.length - 1; i++) {
        if (nums[i] === key) {
            const nextNum = nums[i + 1];
            freqMap.set(nextNum, (freqMap.get(nextNum) || 0) + 1);
        }
    }
    let maxCount = 0;
    let mostFrequentNum = -1;
    for (const [num, count] of freqMap.entries()) {
        if (count > maxCount) {
            maxCount = count;
            mostFrequentNum = num;
        }
    }
    return mostFrequentNum;
};