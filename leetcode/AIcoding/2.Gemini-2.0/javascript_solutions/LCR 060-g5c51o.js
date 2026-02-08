var topKFrequent = function(nums, k) {
    const frequencyMap = new Map();
    for (const num of nums) {
        frequencyMap.set(num, (frequencyMap.get(num) || 0) + 1);
    }

    const sortedFrequencies = Array.from(frequencyMap.entries()).sort(([, freqA], [, freqB]) => freqB - freqA);

    const result = [];
    for (let i = 0; i < k; i++) {
        result.push(sortedFrequencies[i][0]);
    }

    return result;
};