var dicesProbability = function(n) {
    let dp = new Array(6 * n + 1).fill(0);

    for (let i = 1; i <= 6; i++) {
        dp[i] = 1;
    }

    for (let i = 2; i <= n; i++) {
        let newDp = new Array(6 * n + 1).fill(0);
        for (let j = i; j <= 6 * i; j++) {
            for (let k = 1; k <= 6; k++) {
                if (j - k >= i - 1 && j - k <= 6 * (i - 1)) {
                    newDp[j] += dp[j - k];
                }
            }
        }
        dp = newDp;
    }

    const totalOutcomes = Math.pow(6, n);
    const result = [];

    for (let i = n; i <= 6 * n; i++) {
        result.push(dp[i] / totalOutcomes);
    }

    return result;
};