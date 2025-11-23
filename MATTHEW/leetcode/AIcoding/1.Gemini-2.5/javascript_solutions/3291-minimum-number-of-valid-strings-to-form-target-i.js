var minNumberOfValidStrings = function(words, target) {
    const n = target.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        for (const word of words) {
            if (i >= word.length) {
                const sub = target.substring(i - word.length, i);
                if (sub === word) {
                    if (dp[i - word.length] !== Infinity) {
                        dp[i] = Math.min(dp[i], dp[i - word.length] + 1);
                    }
                }
            }
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
};