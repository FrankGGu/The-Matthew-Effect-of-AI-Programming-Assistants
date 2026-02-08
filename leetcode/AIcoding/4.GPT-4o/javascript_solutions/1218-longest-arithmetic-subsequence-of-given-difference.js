var longestSubsequence = function(arr, difference) {
    const dp = new Map();
    let maxLength = 0;

    for (const num of arr) {
        const prevNum = num - difference;
        dp.set(num, (dp.get(prevNum) || 0) + 1);
        maxLength = Math.max(maxLength, dp.get(num));
    }

    return maxLength;
};