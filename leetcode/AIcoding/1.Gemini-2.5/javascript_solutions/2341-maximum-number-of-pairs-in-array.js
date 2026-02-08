var numberOfPairs = function(nums) {
    const freqMap = new Map();
    for (const num of nums) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    let pairCount = 0;
    let remainingCount = 0;

    for (const count of freqMap.values()) {
        pairCount += Math.floor(count / 2);
        remainingCount += count % 2;
    }

    return [pairCount, remainingCount];
};