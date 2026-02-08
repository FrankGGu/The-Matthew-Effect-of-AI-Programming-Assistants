var longestIdealString = function(s, k) {
    const dp = new Array(26).fill(0);
    let maxLen = 0;

    for (let i = 0; i < s.length; i++) {
        const currentCharCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        let currentMaxPrevLen = 0;

        const startChar = Math.max(0, currentCharCode - k);
        const endChar = Math.min(25, currentCharCode + k);

        for (let prevCharCode = startChar; prevCharCode <= endChar; prevCharCode++) {
            currentMaxPrevLen = Math.max(currentMaxPrevLen, dp[prevCharCode]);
        }

        dp[currentCharCode] = 1 + currentMaxPrevLen;
        maxLen = Math.max(maxLen, dp[currentCharCode]);
    }

    return maxLen;
};