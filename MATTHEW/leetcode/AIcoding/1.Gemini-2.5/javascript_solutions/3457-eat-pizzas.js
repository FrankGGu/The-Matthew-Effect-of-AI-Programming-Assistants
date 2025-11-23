var eatPizzas = function(pizzas, maxCapacity) {
    const n = pizzas.length;
    const dp = Array(n + 1).fill(0).map(() => Array(maxCapacity + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        const currentPizzaWeight = pizzas[i - 1];
        const currentPizzaValue = pizzas[i - 1];

        for (let j = 1; j <= maxCapacity; j++) {
            dp[i][j] = dp[i - 1][j];
            if (j >= currentPizzaWeight) {
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - currentPizzaWeight] + currentPizzaValue);
            }
        }
    }

    return dp[n][maxCapacity];
};