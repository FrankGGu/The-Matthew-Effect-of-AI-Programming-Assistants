var longestIdealString = function(s, k) {
    const dp = new Array(26).fill(0);
    for (const char of s) {
        const index = char.charCodeAt(0) - 'a'.charCodeAt(0);
        let maxLen = 0;
        for (let i = 0; i < 26; i++) {
            if (Math.abs(index - i) <= k) {
                maxLen = Math.max(maxLen, dp[i]);
            }
        }
        dp[index] = maxLen + 1;
    }
    return Math.max(...dp);
};