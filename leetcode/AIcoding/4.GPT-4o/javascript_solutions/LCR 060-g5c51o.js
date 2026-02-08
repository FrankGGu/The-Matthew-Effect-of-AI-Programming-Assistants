var topKFrequent = function(nums, k) {
    const frequencyMap = new Map();
    nums.forEach(num => frequencyMap.set(num, (frequencyMap.get(num) || 0) + 1));

    const sorted = Array.from(frequencyMap.entries()).sort((a, b) => b[1] - a[1]);

    return sorted.slice(0, k).map(entry => entry[0]);
};