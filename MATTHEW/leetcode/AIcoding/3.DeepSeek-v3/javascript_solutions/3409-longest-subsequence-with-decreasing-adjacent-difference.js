var longestSubsequence = function(arr, difference) {
    const dp = {};
    let max = 0;
    for (const num of arr) {
        const prev = num - difference;
        dp[num] = (dp[prev] || 0) + 1;
        max = Math.max(max, dp[num]);
    }
    return max;
};