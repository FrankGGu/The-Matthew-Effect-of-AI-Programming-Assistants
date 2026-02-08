var numSquarefulPerms = function(nums) {
    let count = 0;
    const n = nums.length;
    const freqMap = new Map();

    for (const num of nums) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    const isPerfectSquare = (num) => {
        const root = Math.round(Math.sqrt(num));
        return root * root === num;
    };

    const backtrack = (currentLength, prevNum) => {
        if (currentLength === n) {
            count++;
            return;
        }

        for (const [num, freq] of freqMap.entries()) {
            if (freq > 0) {
                if (isPerfectSquare(prevNum + num)) {
                    freqMap.set(num, freq - 1);
                    backtrack(currentLength + 1, num);
                    freqMap.set(num, freq);
                }
            }
        }
    };

    for (const [num, freq] of freqMap.entries()) {
        freqMap.set(num, freq - 1);
        backtrack(1, num);
        freqMap.set(num, freq);
    }

    return count;
};