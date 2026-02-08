var longestSubsequence = function(arr, target) {
    const dp = new Array(target + 1).fill(0);
    let maxLen = 0;

    for (let num of arr) {
        for (let j = target; j >= num; j--) {
            dp[j] = Math.max(dp[j], dp[j - num] + 1);
            maxLen = Math.max(maxLen, dp[j]);
        }
    }

    return maxLen;
};