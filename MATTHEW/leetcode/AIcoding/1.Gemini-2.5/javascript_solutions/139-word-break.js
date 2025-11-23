var wordBreak = function(s, wordDict) {
    const n = s.length;
    const dp = new Array(n + 1).fill(false);
    dp[0] = true;

    const wordSet = new Set(wordDict);
    let maxWordLength = 0;
    for (const word of wordDict) {
        maxWordLength = Math.max(maxWordLength, word.length);
    }

    for (let i = 1; i <= n; i++) {
        for (let j = i - 1; j >= 0; j--) {
            if (i - j > maxWordLength) {
                break;
            }

            if (dp[j] && wordSet.has(s.substring(j, i))) {
                dp[i] = true;
                break;
            }
        }
    }

    return dp[n];
};