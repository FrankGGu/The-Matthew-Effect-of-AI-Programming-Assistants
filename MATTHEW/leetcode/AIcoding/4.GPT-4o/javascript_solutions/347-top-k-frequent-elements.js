var topKFrequent = function(nums, k) {
    const freqMap = new Map();
    nums.forEach(num => {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    });

    const sorted = [...freqMap.entries()].sort((a, b) => b[1] - a[1]);
    return sorted.slice(0, k).map(entry => entry[0]);
};