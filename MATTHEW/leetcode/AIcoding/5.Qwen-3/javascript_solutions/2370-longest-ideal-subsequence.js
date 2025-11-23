function longestIdealString(s, c) {
    const dp = new Array(26).fill(0);
    for (let i = 0; i < s.length; i++) {
        const idx = s.charCodeAt(i) - 'a'.charCodeAt(0);
        let max = 0;
        for (let j = 0; j < 26; j++) {
            if (Math.abs(j - idx) <= c) {
                max = Math.max(max, dp[j]);
            }
        }
        dp[idx] = Math.max(dp[idx], max + 1);
    }
    return Math.max(...dp);
}