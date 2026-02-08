var longestIdealString = function(s, k) {
    const dp = new Array(26).fill(0);
    for (const c of s) {
        const curr = c.charCodeAt() - 'a'.charCodeAt();
        let maxLen = 0;
        for (let i = Math.max(0, curr - k); i <= Math.min(25, curr + k); i++) {
            maxLen = Math.max(maxLen, dp[i]);
        }
        dp[curr] = maxLen + 1;
    }
    return Math.max(...dp);
};