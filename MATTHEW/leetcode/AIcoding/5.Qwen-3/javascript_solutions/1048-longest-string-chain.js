function longestStrChain(words) {
    words.sort((a, b) => a.length - b.length);
    const dp = {};
    let maxLen = 0;

    for (const word of words) {
        dp[word] = 1;
        for (let i = 0; i < word.length; i++) {
            const prev = word.slice(0, i) + word.slice(i + 1);
            if (dp[prev]) {
                dp[word] = Math.max(dp[word], dp[prev] + 1);
            }
        }
        maxLen = Math.max(maxLen, dp[word]);
    }

    return maxLen;
}