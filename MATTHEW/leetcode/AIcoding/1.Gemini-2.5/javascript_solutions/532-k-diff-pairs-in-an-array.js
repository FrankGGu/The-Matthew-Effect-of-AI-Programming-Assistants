var findPairs = function(nums, k) {
    if (k < 0) {
        return 0;
    }

    if (k === 0) {
        let freqMap = new Map();
        for (let num of nums) {
            freqMap.set(num, (freqMap.get(num) || 0) + 1);
        }

        let count = 0;
        for (let [num, freq] of freqMap) {
            if (freq >= 2) {
                count++;
            }
        }
        return count;
    } else { // k > 0
        let uniqueNums = new Set(nums);
        let count = 0;
        for (let num of uniqueNums) {
            if (uniqueNums.has(num + k)) {
                count++;
            }
        }
        return count;
    }
};