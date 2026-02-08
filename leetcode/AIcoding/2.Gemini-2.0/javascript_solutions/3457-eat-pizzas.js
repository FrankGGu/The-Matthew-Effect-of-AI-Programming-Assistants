var eatPizza = function(slices, k) {
    const n = slices.length;
    if (n === 0) return 0;
    if (n <= 3) return Math.max(...slices);

    function maxPizza(slices, k) {
        const len = slices.length;
        const dp = Array(k + 1).fill(null).map(() => Array(len).fill(0));

        for (let i = 1; i <= k; i++) {
            for (let j = 0; j < len; j++) {
                if (j === 0) {
                    dp[i][j] = slices[j];
                } else {
                    dp[i][j] = Math.max(
                        dp[i][j - 1],
                        (j >= 2 ? dp[i - 1][j - 2] : 0) + slices[j]
                    );
                }
            }
        }

        return dp[k][len - 1];
    }

    let case1 = maxPizza(slices.slice(0, n - 1), Math.floor((n + 1) / 3));
    let case2 = maxPizza(slices.slice(1, n), Math.floor((n + 1) / 3));

    return Math.max(case1, case2);
};