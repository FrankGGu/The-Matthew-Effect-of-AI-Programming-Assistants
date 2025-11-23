var longestSubsequence = function(arr, difference) {
    const dp = new Map();
    let maxLength = 0;

    for (const num of arr) {
        const prevNum = num - difference;
        const lengthEndingWithPrevNum = dp.get(prevNum) || 0;
        const currentLength = lengthEndingWithPrevNum + 1;

        dp.set(num, currentLength);
        maxLength = Math.max(maxLength, currentLength);
    }

    return maxLength;
};