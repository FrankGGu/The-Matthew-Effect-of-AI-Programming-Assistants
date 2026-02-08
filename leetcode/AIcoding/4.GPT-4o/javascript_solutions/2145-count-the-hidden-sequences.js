function countHiddenSequences(nums, diff) {
    const dp = new Map();
    let count = 0;

    for (const num of nums) {
        const prev = num - diff;
        const currentCount = (dp.get(prev) || 0) + 1;
        dp.set(num, currentCount);
        count += currentCount;
    }

    return count;
}