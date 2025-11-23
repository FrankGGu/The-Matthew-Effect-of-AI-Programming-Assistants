var minimumOperations = function(nums) {
    const freq = new Map();
    for (const num of nums) {
        if (num !== 0) {
            freq.set(num, (freq.get(num) || 0) + 1);
        }
    }

    const uniqueNums = Array.from(freq.keys());
    const sortedNums = uniqueNums.sort((a, b) => freq.get(b) - freq.get(a));

    let operations = 0;
    let collected = new Set();

    for (const num of sortedNums) {
        if (!collected.has(num)) {
            operations++;
            collected.add(num);
            for (let i = 1; i <= num; i++) {
                collected.add(i);
            }
        }
    }

    return operations;
};