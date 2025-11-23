function canConstruct(target, words) {
    const dp = new Array(target.length + 1).fill(false);
    dp[0] = true;

    for (let i = 0; i <= target.length; i++) {
        if (dp[i]) {
            for (const word of words) {
                if (target.slice(i, i + word.length) === word) {
                    dp[i + word.length] = true;
                }
            }
        }
    }

    return dp[target.length];
}