var maximumSum = function(nums) {
    const map = new Map();
    let maxSum = -1;

    for (const num of nums) {
        const digitSum = String(num).split('').reduce((acc, digit) => acc + Number(digit), 0);
        if (map.has(digitSum)) {
            maxSum = Math.max(maxSum, map.get(digitSum) + num);
            map.set(digitSum, Math.max(map.get(digitSum), num));
        } else {
            map.set(digitSum, num);
        }
    }

    return maxSum;
};