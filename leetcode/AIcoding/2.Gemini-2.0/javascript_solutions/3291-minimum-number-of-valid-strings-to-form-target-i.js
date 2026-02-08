var minNumber = function(target, wordBank) {
    const n = target.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < n; i++) {
        if (dp[i] === Infinity) continue;

        for (const word of wordBank) {
            if (target.substring(i).startsWith(word)) {
                dp[i + word.length] = Math.min(dp[i + word.length], dp[i] + 1);
            }
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
};