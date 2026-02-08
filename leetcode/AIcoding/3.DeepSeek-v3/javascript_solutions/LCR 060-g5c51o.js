var topKFrequent = function(nums, k) {
    const frequencyMap = new Map();
    for (const num of nums) {
        frequencyMap.set(num, (frequencyMap.get(num) || 0) + 1);
    }

    const uniqueNums = Array.from(frequencyMap.keys());
    uniqueNums.sort((a, b) => frequencyMap.get(b) - frequencyMap.get(a));

    return uniqueNums.slice(0, k);
};