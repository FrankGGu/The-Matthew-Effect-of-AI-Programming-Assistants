var longestSubsequence = function(arr, difference) {
    const dp = new Map();
    let max = 0;
    for (const num of arr) {
        const prev = num - difference;
        const count = (dp.get(prev) || 0) + 1;
        dp.set(num, count);
        max = Math.max(max, count);
    }
    return max;
};