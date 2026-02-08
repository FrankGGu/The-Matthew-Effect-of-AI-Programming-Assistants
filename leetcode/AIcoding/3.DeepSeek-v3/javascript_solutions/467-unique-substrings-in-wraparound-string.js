var findSubstringInWraproundString = function(p) {
    const dp = new Array(26).fill(0);
    let maxLen = 0;
    for (let i = 0; i < p.length; i++) {
        if (i > 0 && (p.charCodeAt(i) - p.charCodeAt(i - 1) === 1 || p.charCodeAt(i - 1) - p.charCodeAt(i) === 25)) {
            maxLen++;
        } else {
            maxLen = 1;
        }
        const index = p.charCodeAt(i) - 'a'.charCodeAt(0);
        dp[index] = Math.max(dp[index], maxLen);
    }
    return dp.reduce((sum, val) => sum + val, 0);
};