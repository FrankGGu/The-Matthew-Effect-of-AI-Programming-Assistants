function minCoins(fruits) {
    const dp = new Array(fruits.length + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= fruits.length; i++) {
        for (let j = 0; j < i; j++) {
            if (fruits[j] <= fruits[i - 1]) {
                dp[i] = Math.min(dp[i], dp[j] + 1);
            }
        }
    }

    return dp[fruits.length] === Infinity ? -1 : dp[fruits.length];
}