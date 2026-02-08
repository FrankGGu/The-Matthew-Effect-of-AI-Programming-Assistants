var isPossibleDivide = function(nums, k) {
    if (nums.length % k !== 0) {
        return false;
    }

    nums.sort((a, b) => a - b);

    const freqMap = new Map();
    for (const num of nums) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    for (const num of nums) {
        if (freqMap.get(num) === 0) {
            continue;
        }

        for (let i = 0; i < k; i++) {
            const currentNum = num + i;
            if ((freqMap.get(currentNum) || 0) === 0) {
                return false;
            }
            freqMap.set(currentNum, freqMap.get(currentNum) - 1);
        }
    }

    return true;
};