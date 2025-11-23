var frequencySort = function(nums) {
    const freqMap = new Map();
    for (const num of nums) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    nums.sort((a, b) => {
        const freqA = freqMap.get(a);
        const freqB = freqMap.get(b);

        if (freqA !== freqB) {
            return freqA - freqB;
        } else {
            return b - a;
        }
    });

    return nums;
};