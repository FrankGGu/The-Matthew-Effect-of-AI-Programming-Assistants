function longestPalindromeSubseq(s) {
    const n = s.length;
    const dp = Array.from({ length: n }, () => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i < n - len + 1; i++) {
            const j = i + len - 1;
            if (s[i] === s[j]) {
                dp[i][j] = dp[i + 1][j - 1] + 2;
            } else {
                dp[i][j] = Math.max(dp[i + 1][j], dp[i][j - 1]);
            }
        }
    }

    return dp[0][n - 1];
}

function maxPalindromicSubsequenceLength(s) {
    const uniqueChars = new Set(s);
    let maxLength = 0;

    for (const char of uniqueChars) {
        const count = s.split(char).length - 1;
        maxLength += Math.floor(count / 2) * 2;
        if (count % 2 === 1 && maxLength % 2 === 0) {
            maxLength++;
        }
    }

    return maxLength;
}

var longestPalindrome = function(s) {
    const palindromicLength = longestPalindromeSubseq(s);
    const maxLength = maxPalindromicSubsequenceLength(s);
    return Math.max(palindromicLength, maxLength);
};