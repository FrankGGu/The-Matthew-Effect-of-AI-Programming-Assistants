var findLHS = function(nums) {
    const freqMap = new Map();
    for (const num of nums) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    let maxLen = 0;
    for (const num of freqMap.keys()) {
        if (freqMap.has(num + 1)) {
            maxLen = Math.max(maxLen, freqMap.get(num) + freqMap.get(num + 1));
        }
    }

    return maxLen;
};