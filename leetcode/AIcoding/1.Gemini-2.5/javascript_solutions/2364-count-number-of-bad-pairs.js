var countBadPairs = function(nums) {
    const n = nums.length;
    let goodPairsCount = 0;
    const freqMap = new Map();

    for (let i = 0; i < n; i++) {
        const value = nums[i] - i;
        if (freqMap.has(value)) {
            goodPairsCount += freqMap.get(value);
        }
        freqMap.set(value, (freqMap.get(value) || 0) + 1);
    }

    const totalPairs = (n * (n - 1)) / 2;
    return totalPairs - goodPairsCount;
};