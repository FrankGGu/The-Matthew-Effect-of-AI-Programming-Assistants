var duplicateNumbersXOR = function(nums) {
    const counts = new Map();
    let xorSum = 0;

    for (const num of nums) {
        counts.set(num, (counts.get(num) || 0) + 1);
        if (counts.get(num) === 2) {
            xorSum ^= num;
        }
    }

    return xorSum;
};