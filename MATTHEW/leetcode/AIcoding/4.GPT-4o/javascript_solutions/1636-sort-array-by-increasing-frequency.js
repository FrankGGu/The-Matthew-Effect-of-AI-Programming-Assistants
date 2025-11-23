var frequencySort = function(nums) {
    const freqMap = {};
    for (const num of nums) {
        freqMap[num] = (freqMap[num] || 0) + 1;
    }
    return nums.sort((a, b) => {
        const freqDiff = freqMap[a] - freqMap[b];
        return freqDiff !== 0 ? freqDiff : b - a;
    });
};