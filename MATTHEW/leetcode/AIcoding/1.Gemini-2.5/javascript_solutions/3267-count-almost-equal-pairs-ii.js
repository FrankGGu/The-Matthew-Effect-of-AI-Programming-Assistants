var countAlmostEqualPairs = function(nums, k) {
    let count = 0;
    let freqMap = new Map();

    for (let num of nums) {
        count += freqMap.get(num) || 0;
        if (k !== 0) {
            count += freqMap.get(num - k) || 0;
            count += freqMap.get(num + k) || 0;
        }
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    return count;
};