var isPossibleDivide = function(nums, k) {
    if (nums.length % k !== 0) return false;

    const countMap = new Map();
    for (const num of nums) {
        countMap.set(num, (countMap.get(num) || 0) + 1);
    }

    nums.sort((a, b) => a - b);

    for (const num of nums) {
        if (countMap.get(num) > 0) {
            for (let i = 0; i < k; i++) {
                const currentNum = num + i;
                if (!countMap.has(currentNum) || countMap.get(currentNum) === 0) {
                    return false;
                }
                countMap.set(currentNum, countMap.get(currentNum) - 1);
            }
        }
    }

    return true;
};