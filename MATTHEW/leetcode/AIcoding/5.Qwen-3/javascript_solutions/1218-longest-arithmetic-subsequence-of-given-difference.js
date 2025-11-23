function longestSubsequence(arr, difference) {
    const dp = {};
    let maxLen = 0;
    for (const num of arr) {
        const prev = dp[num - difference] || 0;
        dp[num] = prev + 1;
        if (dp[num] > maxLen) {
            maxLen = dp[num];
        }
    }
    return maxLen;
}